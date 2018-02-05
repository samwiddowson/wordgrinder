require("tests/testsuite")


local document_set_changed = function()
	return DocumentSet.changed or false
end

local document_changed = function(document)
	return document.changed or false
end

local testdoc1 = CreateDocument()
testdoc1:appendParagraph("P", "This is a test.")

--default to global default filetype
AssertEquals(GetDefaultIoFormat(), testdoc1.filetype)

DocumentSet = CreateDocumentSet()
DocumentSet.menu = CreateMenu()
DocumentSet.documents = {}

AssertEquals(false, document_set_changed())

DocumentSet:addDocument(testdoc1, "test1")

--track changed for indiv. docs and document set
AssertEquals(true, document_set_changed())
AssertEquals(false, document_changed(testdoc1))
local testdoc2 = CreateDocument()
testdoc2:appendParagraph("P", "This is another test.")

DocumentSet:addDocument(testdoc2, "test2")
testdoc2:touch()

--track changed for indiv. docs and document set
AssertEquals(true, document_set_changed())
AssertEquals(false, document_changed(testdoc1))
AssertEquals(true, document_changed(testdoc2))

--documentset clean and doc clean
DocumentSet:clean("test1")

AssertEquals(false, document_set_changed())
AssertEquals(false, document_changed(testdoc1))
AssertEquals(true, document_changed(testdoc2))

testdoc2:clean()
AssertEquals(false, document_changed(testdoc2))
