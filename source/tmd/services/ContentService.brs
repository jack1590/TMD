function ContentService(config as Object) as Object
    this = {
        name: "ContentService"
        logger: Logger()
        request: Requests()
        config: config

        '|----------------------------------------------|
        '|              Public Methods                  |
        '|----------------------------------------------|

        getContentByGenreId: function(genreId as String, page as Integer) as Object
            m.logger.verbose("Getting content by genre", m.name, { genreId: genreId, pase: page })
            headers = { "Authorization": "Bearer " + m.config.tmdAcessToken }
            url = m.config.discoverEndpoint + m._buildQueryParams(page, genreId)
            return m.request.get(url, { "headers": headers })
        end function

        '|----------------------------------------------|
        '|              Private Methods                 |
        '|----------------------------------------------|
        _init: function() as Void
            if m.config = invalid
                m.logger.error("config is invalid")
            end if
        end function

        _buildQueryParams: function(page as Integer, genreId as String) as String
            params = m.config.discoverFilters
            params.page = page
            params.with_genres = genreId
            queryString = "?"
            for each key in params
                if queryString.len() > 1
                    queryString = queryString + "&"
                end if
                queryString = queryString + key + "=" + params[key].toStr()
            end for
            return queryString
        end function
    }

    this._init()
    return this
end function
