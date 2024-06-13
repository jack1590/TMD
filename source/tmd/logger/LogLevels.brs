'---------
' LogLevels:
' Declare all possible log levels
' @return {object}
'---------
function LogLevels() as Object
    if m.Logger_LogLevels = invalid
        m.Logger_LogLevels = {
            SILENT: 0
            ERROR: 1
            WARN: 2
            INFO: 3
            VERBOSE: 4
        }
    end if
    return m.Logger_LogLevels
end function
