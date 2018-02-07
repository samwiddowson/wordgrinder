require("tests/testsuite")

local function run_export_format_test(fileformat, comparison_filename)
	local function get_file_content(filename)
		local file = io.open(filename)
		content = file:read("*a")
		io.close(file)
		return content
	end

	local exporter = fileformat.exporter
	local export_filename = os.tmpname()

	document = CreateDocument()
	document.name = "main"
	document[1] = CreateParagraph("P", "This is a test.")

	exporter(export_filename, document)

	exported_content = get_file_content(export_filename) 
	comparison_content = get_file_content(comparison_filename)

	AssertEquals(comparison_content, exported_content)
end

local fileformats = GetIoFileFormats()

run_export_format_test(fileformats.WordGrinder, "testdocs/test.wgd")
run_export_format_test(fileformats.Text, "testdocs/test.txt")
run_export_format_test(fileformats.HTML, "testdocs/test.html")
run_export_format_test(fileformats.OpenDocument, "testdocs/test.odt")
run_export_format_test(fileformats.Markdown, "testdocs/test.md")
run_export_format_test(fileformats.troff, "testdocs/test.tr")
run_export_format_test(fileformats.LaTex, "testdocs/test.tex")
