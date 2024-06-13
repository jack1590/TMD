function GenresService(config as Object) as Object
    this = {
        name: "GenresService"
        logger: Logger()
        request: Requests()
        config: config

        '|----------------------------------------------|
        '|              Public Methods                  |
        '|----------------------------------------------|

        getGenres: function() as Object
            m.logger.verbose("Getting genres", m.name)
            headers = { "Authorization": "Bearer " + m.config.tmdAcessToken }
            return m.request.get(m.config.movieGenreEndpoint, { "headers": headers })
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
