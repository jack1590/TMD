'---------
' Logger:
' Logger Object
' @param {integer} [logLevel=LogLevels().VERBOSE] to set the level of verbosity
' @return {object}
'---------
function Logger(logLevel = LogLevels().VERBOSE as Integer) as Object
    this = {
        defaultParamsValue: "_logparams_"
        loggerLogLevel: invalid
        logPrefix: "MSG - "
        logContext: ""
        logLevels: [
            "SILENT " ' not used
            "ERROR  "
            "WARN   "
            "INFO   "
            "VERBOSE"
        ]
        logColors: [
            "0m" ' SILENT
            "31;1m" ' ERROR
            "33;1m" ' WARN
            "34;1m" ' INFO
            "32;1m" ' VERBOSE
        ]
        global: m.global
        logLevel: invalid

        '|----------------------------------------------|
        '|              Public Methods                  |
        '|----------------------------------------------|
        verbose: function(message as String, context = "" as String, params = m.defaultParamsValue as Dynamic) as Void
            m._log(message, LogLevels().VERBOSE, context, params)
        end function

        info: function(message as String, context = "" as String, params = m.defaultParamsValue as Dynamic) as Void
            m._log(message, LogLevels().INFO, context, params)
        end function

        warn: function(message as String, context = "" as String, params = m.defaultParamsValue as Dynamic) as Void
            m._log(message, LogLevels().WARN, context, params)
        end function

        error: function(message as String, context = "" as String, params = m.defaultParamsValue as Dynamic) as Void
            m._log(message, LogLevels().ERROR, context, params)
        end function

        '|----------------------------------------------|
        '|              Private Methods                 |
        '|----------------------------------------------|
        _init: function(level as Object) as Void
            if level < LogLevels().SILENT then
                m.logLevel = LogLevels().SILENT
            else if level > LogLevels().VERBOSE
                m.logLevel = LogLevels().VERBOSE
            else
                m.logLevel = level
            end if
            if m.global <> invalid AND m.global.apiConfig <> invalid AND m.global.apiConfig.logLevel <> invalid
                m.logLevel = m.global.apiConfig.logLevel
            end if
        end function

        _log: function(message as String, level as Integer, context as String, params as Dynamic) as Void
            if m.logLevel < level then
                return
            end if

            msg = m._formatMessage(message, level, context)
            logParams = m._formatParams(params)
            if logParams <> invalid AND logParams <> "" then
                msg += ": " + logParams
            end if
            m._print(Chr(27) + "[" + m.logColors[level] + msg + Chr(27) + "[" + m.logColors[0])
        end function

        _print: function(msg as String) as Void
            print msg
        end function

        _formatMessage: function(message as String, level as Integer, context = m.logContext as String) as String
            timestamp = m._getTimestamp()
            if context <> invalid AND context <> ""
                msg = Substitute("{0} {1} [{2}: {3}] ", timestamp, m.logLevels[level], m.logPrefix, context)
            else
                msg = Substitute("{0} {1} [{2}] ", timestamp, m.logLevels[level], m.logPrefix)
            end if
            msg += message
            return msg
        end function

        _formatParams: function(params as Dynamic) as String
            result = ""
            if GetInterface(params, "ifAssociativeArray") <> invalid then
                fields = []
                for each key in params.keys()
                    fields.push(key + "=" + m._objectToString(params[key]))
                end for
                result = fields.join(", ")
            else if type(params) <> "roString" OR params <> m.defaultParamsValue then
                result = "data=" + m._objectToString(params)
            end if
            return result
        end function

        _getTimestamp: function() as String
            dateObj = CreateObject("roDateTime")
            rawDate = dateObj.ToISOString()
            return Substitute("{0} {1}", rawDate.mid(0, 10), rawDate.mid(11, 8))
        end function

        _objectToString: function(obj as Dynamic) as String
            objType = type(obj)
            if objType = "roAssociativeArray" OR objType = "roArray" then
                result = FormatJson(obj)
                if result <> "" then
                    return result
                else
                    return type(obj)
                end if
            else if objType = "roDateTime" then
                return obj.toISOString()
            else if GetInterface(obj, "ifToStr") <> invalid then
                return obj.toStr()
            else
                return type(obj)
            end if
        end function
    }

    this._init(logLevel)
    return this

end function
