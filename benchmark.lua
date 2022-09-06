return function(name, amount, fn, ...)
    coroutine.wrap(function(a, b, c, ...)
        collectgarbage()

        local sTime = SysTime()

        for i = 0, b do
            c(...)
        end

        print( ('Benchmark \'%s\' (x%d) took %d+ms.'):format(a, b, (SysTime() - sTime) * 1000 ) )
    end)(name, amount, fn, ...)
end