require("tests/testsuite")


DocumentSet = CreateDocumentSet()
DocumentSet.menu = CreateMenu()
DocumentSet.documents = {}

local doc = CreateDocument()
doc:appendParagraph("P", "This is a test.")

DocumentSet:addDocument(doc, "test1")

--default to global default filetype
AssertEquals(GetDefaultIoFormat(), DocumentSet.documents["test1"].filetype)
