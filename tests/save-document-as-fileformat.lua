require("tests/testsuite")

local function test_document_content(document, savefilename, comparisonfilename, fileformat)
	local function get_file_content(filename)
		local file = io.open(filename)
		content = file:read("*a")
		io.close(file)
		return content
	end

	AssertEquals(fileformat, document.ioFileFormat)

	local exported_content = get_file_content(savefilename) 
	local comparison_content = get_file_content("testdocs/"..comparisonfilename)

	AssertEquals(comparison_content, exported_content)

	AssertEquals(savefilename, document.filename)
	AssertEquals(Leafname(savefilename), document.name)
end

DocumentSet.name = os.tmpname()

local document = CreateDocument()
document[1] = CreateParagraph("P", "This is a test.")

DocumentSet:addDocument(document, "test.html")
local htmlfilename = os.tmpname()
local odtfilename = os.tmpname()
local txtfilename = os.tmpname()
local wgdfilename = os.tmpname()

Cmd.SaveAsHTMLFile(htmlfilename, document)
test_document_content(document, htmlfilename, "test.html", "HTML")

Cmd.SaveAsODTFile(odtfilename, document)
test_document_content(document, odtfilename, "test.odt", "OpenDocument")

Cmd.SaveAsWGFile(wgdfilename, document)
test_document_content(document, wgdfilename, "test.wgd", "WordGrinder")

DocumentSet:setCurrent(document.name)
AssertTableEquals(document, Document)
Cmd.SaveAsTextFile(txtfilename)
test_document_content(Document, txtfilename, "test.txt", "Text")
