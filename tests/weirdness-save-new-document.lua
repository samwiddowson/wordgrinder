require("tests/testsuite")

Cmd.InsertStringIntoParagraph("fnord")
AssertClass(Document[1], ParagraphClass)
Cmd.AddBlankDocument("other")
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

