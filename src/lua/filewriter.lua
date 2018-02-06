-- © 2008-2013 David Given.
-- WordGrinder is licensed under the MIT open source license. See the COPYING
-- file in this distribution for the full text.

FileWriterClass = {
	open = function(self)
		self.file, self.err = io.open(self.filename..".new", "w")
		if not self.file then
			return false
		end
		return true
	end,

	getBufferAsString = function(self)
		return table.concat(self._buffer)
	end,

	writeToBuffer = function(self, ...)
		for _, t in ipairs({...}) do
			local text
			if (type(t) == table) then
				text = table.concat(t)
			else
				text = t
			end
			self._buffer[#self._buffer + 1]  = text
		end

	end,

	finalize = function(self)
		self.file:write(self:getBufferAsString())
		self.file:close()

		--Do the filename dance to avoid corrupting files when crashing on write...
		local r
		r, self.err = os.rename(self.filename, self.filename..".old")
		if not self.err then
			r, self.err = os.rename(self.filename..".new", self.filename)
		end
		if not self.err then
			r, self.err = os.remove(self.filename..".old")
		end
	end,
}

function CreateFileWriter(fn)
	local fw = {
		file = nil,
		filename = fn,
		_buffer = {},
		err = nil,
	}
	if fn then
		--Check we can write to the specified file
		fw.file, fw.err = io.open(fn, "w")
		--Close it again; the error has been stored, if any
		if fw.file then
			fw.file:close()
		end
	else
		fw.err = "No filename specified."
	end

	setmetatable(fw, {__index = FileWriterClass})

	return fw
end
