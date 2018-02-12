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
	document.name = comparison_filename
	document[1] = CreateParagraph("P", "This is a test.")

	exporter(export_filename, document)

	exported_content = get_file_content(export_filename) 
	comparison_content = get_file_content("testdocs/"..comparison_filename)

	AssertEquals(comparison_content, exported_content)

	if fileformat.importer then
		AssertEquals(export_filename, document.filename)
	end
end

local fileformats = GetIoFileFormats()

run_export_format_test(fileformats.WordGrinder, "test.wgd")
run_export_format_test(fileformats.Text, "test.txt")
run_export_format_test(fileformats.HTML, "test.html")
run_export_format_test(fileformats.OpenDocument, "test.odt")
run_export_format_test(fileformats.Markdown, "test.md")
run_export_format_test(fileformats.troff, "test.tr")
run_export_format_test(fileformats.LaTex, "test.tex")
