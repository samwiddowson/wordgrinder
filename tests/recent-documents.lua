require("tests/testsuite")

local docsetfilename1 = os.tmpname()

Document[1] = CreateParagraph("P", "This is a test.")
Document.filename = os.tmpname()
Cmd.SaveAllDocuments(docsetfilename1)

AssertEquals(docsetfilename1, GlobalSettings.recents[1])

ResetDocumentSet()

local docsetfilename2 = os.tmpname()

Document[1] = CreateParagraph("P", "This is a test.")
Document.filename = os.tmpname()
Cmd.SaveAllDocuments(docsetfilename2)

AssertEquals(docsetfilename2, GlobalSettings.recents[1])
AssertEquals(docsetfilename1, GlobalSettings.recents[2])

--test reloading puts a document to the top of the list
Cmd.LoadDocumentSet(docsetfilename1)

AssertEquals(docsetfilename1, GlobalSettings.recents[1])
AssertEquals(docsetfilename2, GlobalSettings.recents[2])

--test loading a filename that's no longer there removes it from the list.
--[[
os.rename(docsetfilename2, os.tmpname())

Cmd.LoadDocumentSet(docsetfilename2)

AssertEquals(docsetfilename1, GlobalSettings.recents[1])
AssertEquals(nil, GlobalSettings.recents[2])
]]
