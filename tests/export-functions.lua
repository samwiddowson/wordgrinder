require("tests/testsuite")

local function run_export_format_test(exporter, comparison_filename)
	local function get_file_content(filename)
		local file = io.open(filename)
		content = file:read("*a")
		io.close(file)
		return content
	end
	local export_filename = os.tmpname()

	Document = CreateDocument()
	Document[1] = CreateParagraph("P", "This is a test.")

	exporter(export_filename)

	exported_content = get_file_content(export_filename) 
	comparison_content = get_file_content(comparison_filename)

	AssertEquals( comparison_content, exported_content )
end

run_export_format_test(Cmd.ExportWGFile, "testdocs/test.wgd")
