require("tests/testsuite")

Cmd.InsertStringIntoParagraph("fnord")
AssertClass(Document[1], ParagraphClass)
DocumentSet.documents[1].filename = os.tmpname()
DocumentSet.documents[1].ioFileFormat = "WordGrinder"

Cmd.AddBlankDocument("other")
DocumentSet.documents[2].filename = os.tmpname()
DocumentSet.documents[2].ioFileFormat = "WordGrinder"

Cmd.InsertStringIntoParagraph("blarg")
AssertClass(Document[1], ParagraphClass)

local filename = os.tmpname()

AssertEquals(Cmd.SaveCurrentDocumentAs(filename), true)
AssertEquals(Cmd.LoadDocumentSet(filename), true)

Cmd.ChangeDocument("main")
AssertTableEquals({"fnord"}, Document[1])
AssertClass(Document[1], ParagraphClass)
AssertNotNull(Document[1].getLineOfWord)
Cmd.ChangeDocument("other")
AssertTableEquals({"blarg"}, Document[1])
AssertNotNull(Document[1].getLineOfWord)
AssertNotNull(Document[1].style)
