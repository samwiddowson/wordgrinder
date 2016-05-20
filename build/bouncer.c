/* If you're not on the list, you're not getting in.
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <unistd.h>
#include <ctype.h>
#include <errno.h>

struct slist {
	const char* s;
	struct slist* next;
};

static const char** whitelist;
static int whitelist_len;

static void error(const char* s, ...) {
	va_list ap;

	va_start(ap, s);
	fprintf(stderr, "bouncer: ");
	vfprintf(stderr, s, ap);
	fprintf(stderr, "\n");
	va_end(ap);

	exit(1);
}

static struct slist* parse_whitelist_into_list(void) {
	struct slist* list = NULL;
	const char* whitelist_s = getenv("BOUNCER_WHITELIST");
	const char* top_s = getenv("BOUNCER_TOP");
	const char* src = whitelist_s;

	if (!whitelist_s)
		error("no BOUNCER_WHITELIST variable specified");
	if (!top_s)
		error("no BOUNCER_TOP variable specified");

	while (*src) {
		char* path;

		{
			const char* top = (*src == '/') ? "" : top_s;
			const char* start = src;
			const char* end = start;
			int pathlen;

			for (;;) {
				int c = *end;
				if (!c)
					break;
				if (isspace(c))
					break;

				end++;
			}

			pathlen = strlen(top) + (end-start) + 1;
			path = malloc(pathlen);
			snprintf(path, pathlen, "%s%*s", top, (int)(end-start), start);

			src = end;
			while (isspace(*src))
				src++;
		}

		{
			struct slist* node = calloc(1, sizeof(struct slist));
			node->next = list;
			node->s = path;
			list = node;
		}
	}

	return list;
}

static void realpath_list(struct slist* list) {
	while (list) {
		char* path = realpath(list->s, NULL);
		if (!path)
			error("could not validate path '%s': %s", list->s, strerror(errno));

		list->s = path;
		list = list->next;
	}
}

static int count_list(struct slist* list) {
	int count = 0;
	while (list) {
		count++;
		list = list->next;
	}
	return count;
}

int main(int argc, const char* argv[]) {
	struct slist* list = parse_whitelist_into_list();
	realpath_list(list);
	whitelist_len = count_list(list);
	whitelist = calloc(whitelist_len, sizeof(*whitelist));
}

