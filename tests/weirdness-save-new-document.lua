require("tests/testsuite")

Cmd.InsertStringIntoParagraph("fnord")
AssertClass(Document[1], ParagraphClass)
DocumentSet.documents[1].filename = os.tmpname()
DocumentSet.documents[1].ioFileFormat = "WordGrinder"
DocumentSet.documents[1]:touch()

Cmd.AddBlankDocument("other")
DocumentSet.documents[2].filename = os.tmpname()
DocumentSet.documents[2].ioFileFormat = "WordGrinder"
DocumentSet.documents[2]:touch()

Cmd.InsertStringIntoParagraph("blarg")
AssertClass(Document[1], ParagraphClass)

local filename = os.tmpname()

AssertEquals(Cmd.SaveAllDocuments(filename), true)
AssertEquals(Cmd.LoadDocumentSet(filename), true)

Cmd.ChangeDocument("main")
AssertTableEquals({"fnord"}, DocumentSet.documents[1][1])
AssertClass(Document[1], ParagraphClass)
AssertNotNull(Document[1].getLineOfWord)
Cmd.ChangeDocument("other")
AssertTableEquals({"blarg"}, DocumentSet.documents[2][1])
AssertNotNull(Document[1].getLineOfWord)
AssertNotNull(Document[1].style)
