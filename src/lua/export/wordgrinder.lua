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
	if document.integrated then
		ModalMessage(nil, "The Scrapbook document cannot be maintained separately to the session file. Try the Export menu if you wish to save an external copy.")
		QueueRedraw()
		return false
	end
	document.ioFileFormat = GetIoFileFormats().WordGrinder.name
	return SaveDocument(filename, document)
end

function Cmd.ExportWGFile(filename, document)
	local success, filename = ExportFileWithUI(filename, "Export native WordGrinder file", ".wgd", DumpWordGrinderFile, document)
	return success
end
