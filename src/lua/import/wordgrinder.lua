-- © 2008-2013 David Given.
-- WordGrinder is licensed under the MIT open source license. See the COPYING
-- file in this distribution for the full text.


local unpack = rawget(_G, "unpack") or table.unpack
-----------------------------------------------------------------------------
-- The importer itself.

function verifyparagraphstyle(style)
	for _, s in ipairs(DocumentStyles) do
		if s.name == style then	
			return true
		end
	end
end

function loadwordgrinderfile(fp, document)
	local err
	while true do
		local line = fp:read("*l")
		if not line or (line == ".") then
			break
		end

		local words = SplitString(line, " ")
		if (words[1] and not verifyparagraphstyle(words[1])) then
			return false, "The file does not appear to be a valid WordGrinder format file."
		end
		local para = CreateParagraph(unpack(words))

		document:appendParagraph(para)
	end

	document.ioFileFormat = GetIoFileFormats().WordGrinder.name
	return true
end

function Cmd.ImportWGFile(filename, document)
	local r = ImportFileWithUI(filename, "Import WordGrinder File", loadwordgrinderfile, document)
	if DocumentSet.name then
		Cmd.SaveDocumentSet()
	end
	return r
end
