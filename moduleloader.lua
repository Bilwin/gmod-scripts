return function(module, fn)
	local arch = '*'
	if system.IsWindows() then
        arch = 'win' .. (jit.arch == 'x64' and '64' or '32')
	elseif system.IsLinux() then
        arch = 'linux' .. (jit.arch == 'x64' and '64' or '')
	end

	local exist = file.Exists(('lua/bin/%s_%s.dll'):format(module, arch), 'GAME')

	if exist then
		local successfull = ProtectedCall( function() require( module:sub(6, #module) ) end )
		if successfull then
			fn()
			return true
		end
	end

	return false
end