return function(epoch)
    return os.date('!%Y-%m-%dT%TZ', epoch or os.time())
end