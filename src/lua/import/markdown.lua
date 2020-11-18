-- © 2008-2013 David Given.
-- WordGrinder is licensed under the MIT open source license. See the COPYING
-- file in this distribution for the full text.

local ITALIC = wg.ITALIC
local UNDERLINE = wg.UNDERLINE
local BOLD = wg.BOLD
local ParseWord = wg.parseword
local WriteU8 = wg.writeu8
local bitand = bit32.band
local bitor = bit32.bor
local bitxor = bit32.bxor
local bit = bit32.btest
local string_char = string.char
local string_find = string.find
local string_sub = string.sub
local table_concat = table.concat

-----------------------------------------------------------------------------
-- The importer itself.

local function loadmarkdownfile(fp, document)
	if not document then 
		document = CreateDocument()
	end

	local lines = {}

	local data = fp:read("*a")
	htmldata = markdown(data)
	htmldata = "<body>"..htmldata.."</body>"
	local success, err = ParseHtmlData(htmldata, document)
	
	document.ioFileFormat = "Markdown"
	
	return success, err
end

function Cmd.ImportMarkdownFile(filename, document)
	local r = ImportFileWithUI(filename, "Import Markdown File", loadmarkdownfile, document)
	if DocumentSet.name then
		Cmd.SaveDocumentSet()
	end
	return r
end
