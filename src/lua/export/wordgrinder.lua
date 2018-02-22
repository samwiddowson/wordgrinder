-- © 2008-2013 David Given.
-- WordGrinder is licensed under the MIT open source license. See the COPYING
-- file in this distribution for the full text.

-----------------------------------------------------------------------------
-- The exporter itself.

function DumpWordGrinderFile(write, document)
	for _, p in ipairs(document) do
		write(p.style)
		for _, s in ipairs(p) do
			write(" ")
			write(s)
		end

			write("\n")
	end

	write(".")
	write("\n")
end 


function Cmd.SaveAsWGFile(filename, document)
	if not document then
		document = Document
	end
	document.ioFileFormat = GetIoFileFormats().WordGrinder.name
	document.filename = filename
	SaveDocument(document)
	return Cmd.SaveDocumentSet()
end

function Cmd.ExportWGFile(filename, document)
	local success, filename = ExportFileWithUI(filename, "Export native WordGrider file", ".wgd", DumpWordGrinderFile, document)
	if success then
		document.filename = filename
		if document.name ~= Leafname(filename) then
			DocumentSet:renameDocument(document.name, Leafname(filename))
		end
	end
	return success
end
