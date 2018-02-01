require("tests/testsuite")

local function run_import_format_test(importer, filename, fileformat)

	local function test_document_content(document)
		AssertEquals(fileformat, document.ioFormat)
		--get first paragraph
		local para = document[1]

		--assert it's a paragraph
		AssertClass(para, ParagraphClass)

		--assert it says "This is a test."
		AssertEquals("This is a test.", para:asString())
	end

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


run_import_format_test(Cmd.ImportTextFile, "testdocs/test.txt", FileFormats.TEXT)
run_import_format_test(Cmd.ImportHTMLFile, "testdocs/test.html", FileFormats.HTML)
run_import_format_test(Cmd.ImportODTFile, "testdocs/test.odt", FileFormats.ODT)
