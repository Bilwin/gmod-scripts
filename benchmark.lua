return function(name, amount, fn, ...)
    coroutine.wrap(function(a, b, c, ...)
        collectgarbage()

        local sTime = os.clock()
    
        for i = 0, b do
            c(...)
        end

        print( ('Benchmark \'%s\' (x%d) took %.0fms.'):format(a, b, (os.clock() - sTime) * 1000 ) )
    end)(name, amount, fn, ...)
end