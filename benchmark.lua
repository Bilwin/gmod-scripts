return function(name, amount, fn, ...)
    collectgarbage()

    local sTime = os.clock()

    for i = 0, amount do
        fn(...)
    end

    print( ('Benchmark \'%s\' (x%d) took %.0fms.'):format(name, amount, (os.clock() - sTime) * 1000 ) )
end