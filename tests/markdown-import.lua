require("tests/testsuite")

local filename = "testdocs/import-test.md"
Cmd.ImportMarkdownFile(filename)

AssertEquals("import-test.md", Document.name)

AssertEquals("H1", Document[1].style)
AssertEquals("Heading 1", Document[1]:asString())

AssertEquals("H2", Document[2].style)
AssertEquals("Heading 2", Document[2]:asString())

AssertEquals("H3", Document[3].style)
AssertEquals("Heading 3", Document[3]:asString())

AssertEquals("H4", Document[4].style)
AssertEquals("Heading 4", Document[4]:asString())

AssertEquals("H1", Document[5].style)
AssertEquals("Heading 1a", Document[5]:asString())

AssertEquals("H2", Document[6].style)
AssertEquals("Heading 2a", Document[6]:asString())

