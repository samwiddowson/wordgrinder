require("tests/testsuite")

local success = Cmd.LoadDocumentSet("testdocs/File-v8-test.wg")

AssertEquals(true, success)

local fileformats = GetIoFileFormats()
local doc1 = DocumentSet.documents[1]

AssertEquals("test.wgd", doc1.name)
AssertEquals(fileformats.WordGrinder.name, doc1.ioFileFormat)
AssertEquals("This is a test.", doc1[1]:asString())


local doc2 = DocumentSet.documents[2]

AssertEquals("test.html", doc2.name)
AssertEquals(fileformats.HTML.name, doc2.ioFileFormat)
AssertEquals("This is a test.", doc2[1]:asString())


local doc3 = DocumentSet.documents[3]

AssertEquals("test.txt", doc3.name)
AssertEquals(fileformats.Text.name, doc3.ioFileFormat)
AssertEquals("This is a test.", doc3[1]:asString())


local doc4 = DocumentSet.documents[4]

AssertEquals("test.odt", doc4.name)
AssertEquals(fileformats.OpenDocument.name, doc4.ioFileFormat)
AssertEquals("This is a test.", doc4[1]:asString())
