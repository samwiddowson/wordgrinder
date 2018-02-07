require("tests/testsuite")

local function run_import_format_test(fileformat, filename)

	local function test_document_content(document)
		AssertEquals(fileformat.name, document.ioFileFormat)
		--get first paragraph
		local para = document[1]

		--assert it's a paragraph
		AssertClass(para, ParagraphClass)

		--assert it says "This is a test."
		AssertEquals("This is a test.", para:asString())
	end

	local importer = fileformat.importer

	-----------------------------
	--Test with pre-created document
	local doc = CreateDocument();
	importer(filename, doc)
	test_document_content(doc)

	-----------------------------
	--Test without re-created document
	--(automatic DocumentSet handling)
	DocumentSet = CreateDocumentSet()
	DocumentSet.menu = CreateMenu()
	DocumentSet.documents = {}

	importer(filename)
	doc = DocumentSet.documents[1]
	test_document_content(doc)
end

local fileformats = GetIoFileFormats()

run_import_format_test(fileformats.Text, "testdocs/test.txt")
run_import_format_test(fileformats.HTML, "testdocs/test.html")
run_import_format_test(fileformats.OpenDocument, "testdocs/test.odt")
run_import_format_test(fileformats.WordGrinder, "testdocs/test.wgd")
