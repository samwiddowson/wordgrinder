-- © 2008-2013 David Given.
-- WordGrinder is licensed under the MIT open source license. See the COPYING
-- file in this distribution for the full text.

-----------------------------------------------------------------------------
-- The importer itself.

local function exportwordgrinder(write, document)
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


function Cmd.ExportWGFile(filename)
	return ExportFileWithUI(filename, "Export native WordGrider file", ".wgd", exportwordgrinder)
end
