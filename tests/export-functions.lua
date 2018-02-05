require("tests/testsuite")

local function run_export_format_test(filetype, exporter, comparison_filename, supportsimport)
	local function get_file_content(filename)
		local file = io.open(filename)
		content = file:read("*a")
		io.close(file)
		return content
	end
	local export_filename = os.tmpname()
	document = CreateDocument()
	document.name = "main"
	document[1] = CreateParagraph("P", "This is a test.")

	exporter(export_filename, document)

	exported_content = get_file_content(export_filename) 
	comparison_content = get_file_content(comparison_filename)

	AssertEquals(comparison_content, exported_content)

	if supportsimport then
		AssertEquals(filetype, document.filetype)
	end
end

run_export_format_test(FileFormats.WORDGRINDER, Cmd.ExportWGFile, "testdocs/test.wgd", true)
run_export_format_test(FileFormats.TEXT, Cmd.ExportTextFile, "testdocs/test.txt", true)
run_export_format_test(FileFormats.HTML, Cmd.ExportHTMLFile, "testdocs/test.html", true)
run_export_format_test(FileFormats.OPENDOCUMENT, Cmd.ExportODTFile, "testdocs/test.odt", true)
run_export_format_test(FileFormats.MARKDOWN, Cmd.ExportMarkdownFile, "testdocs/test.md")
run_export_format_test(FileFormats.TROFF, Cmd.ExportTroffFile, "testdocs/test.tr")
run_export_format_test(FileFormats.LATEX, Cmd.ExportLatexFile, "testdocs/test.tex")
