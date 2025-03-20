local debug = {
    enabled = false
}

function debug.setEnabled(value)
    debug.enabled = value
end

function debug.print(message)
    if debug.enabled then
        print(message)
    end
end

return debug
