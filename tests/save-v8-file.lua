require("tests/testsuite")

local testcontent = "This is a test."
local docsetfilename = os.tmpname()

local htmlvalues = {
	testfile = os.tmpname(),
	comparisonfile = "testdocs/test.html",
	docname = "test.html",
	ioFileFormat = "HTML"
}
local odtvalues = {
	testfile = os.tmpname(),
	comparisonfile = "testdocs/test.odt",
	docname = "test.odt",
	ioFileFormat = "OpenDocument"
}
local txtvalues = {
	testfile = os.tmpname(),
	comparisonfile = "testdocs/test.txt",
	docname = "test.txt",
	ioFileFormat = "Text"
}
local wgdvalues = {
	testfile = os.tmpname(),
	comparisonfile = "testdocs/test.wgd",
	docname = "test.wgd",
	ioFileFormat = "WordGrinder"
}
local function create_test_document(testvalues)
	local doc = CreateDocument()
	doc.filename = testvalues.testfile
	doc.ioFileFormat = testvalues.ioFileFormat
	doc[1] = CreateParagraph("P", "This is a test.")
	DocumentSet:addDocument(doc, testvalues.docname)
	return doc
end

local function test_document_content(document, testvalues)
	local testfile = io.open(testvalues.testfile, "r")
	local testfilecontent = testfile:read("*a")
	testfile:close()

	local comparisonfile = io.open(testvalues.comparisonfile, "r")
	local comparisonfilecontent = comparisonfile:read("*a")
	comparisonfile:close()

	AssertEquals(comparisonfilecontent, testfilecontent)
end

DocumentSet = CreateDocumentSet()
DocumentSet.menu = CreateMenu()
DocumentSet.documents = {}

local htmldoc = create_test_document(htmlvalues)
local odtdoc = create_test_document(odtvalues)
local txtdoc = create_test_document(txtvalues)
local wgddoc = create_test_document(wgdvalues)

Cmd.SaveCurrentDocumentAs(docsetfilename)

test_document_content(htmldoc, htmlvalues)
test_document_content(odtdoc, odtvalues)
test_document_content(txtdoc, txtvalues)
test_document_content(wgddoc, wgdvalues)

local docsetfile = io.open(docsetfilename)

local line = docsetfile:read("*l")
AssertEquals("WordGrinder dumpfile v4: this is a text file; diff me!", line)

local firstdocumentlinefound
while line do
	line = docsetfile:read("*l")
	if line == "#1" then
		firstdocumentlinefound = true
		break
	elseif not line then
		break
	end
end

AssertEquals(true, firstdocumentlinefound)

line = docsetfile:read("*l")
AssertEquals("HTML", line)

line = docsetfile:read("*l")
AssertEquals(htmlvalues.testfile, line) 

line = docsetfile:read("*l")
AssertEquals(".", line)


line = docsetfile:read("*l")
AssertEquals("#2", line)

line = docsetfile:read("*l")
AssertEquals("OpenDocument", line)

line = docsetfile:read("*l")
AssertEquals(odtvalues.testfile, line) 

line = docsetfile:read("*l")
AssertEquals(".", line)


line = docsetfile:read("*l")
AssertEquals("#3", line)

line = docsetfile:read("*l")
AssertEquals("Text", line)

line = docsetfile:read("*l")
AssertEquals(txtvalues.testfile, line) 

line = docsetfile:read("*l")
AssertEquals(".", line)


line = docsetfile:read("*l")
AssertEquals("#4", line)

line = docsetfile:read("*l")
AssertEquals("WordGrinder", line)

line = docsetfile:read("*l")
AssertEquals(wgdvalues.testfile, line) 

line = docsetfile:read("*l")
AssertEquals(".", line)


line = docsetfile:read("*l")
AssertNull(line)

docsetfile:close()
