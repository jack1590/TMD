function ContentService(config as Object) as Object
    this = {
        name: "ContentService"
        logger: Logger()
        request: Requests()
        config: config

        '|----------------------------------------------|
        '|              Public Methods                  |
        '|----------------------------------------------|

        getContentByGenreId: function(genreId as String) as Object
            m.logger.verbose("Getting content by genre", m.name, genreId)
            headers = { "Authorization": "Bearer " + m.config.tmdAcessToken }
            return m.request.get(m.config.discoverEndpoint, { "headers": headers })
        end function

        '|----------------------------------------------|
        '|              Private Methods                 |
        '|----------------------------------------------|
        _init: function() as Void
            if m.config = invalid
                m.logger.error("config is invalid")
            end if
        end function
    }

    this._init()
    return this
end function
