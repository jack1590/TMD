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
            movieGenres = m._getGenres(m.config.movieGenreEndpoint)
            tvGenres = m._getGenres(m.config.tvGenreEndpoint)
            return m._joinGenres([movieGenres, tvGenres])
        end function

        '|----------------------------------------------|
        '|              Private Methods                 |
        '|----------------------------------------------|
        _init: function() as Void
            if m.config = invalid
                m.logger.error("config is invalid")
            end if
        end function

        _getGenres: function(endpoint as String) as Object
            headers = { "Authorization": "Bearer " + m.config.tmdAcessToken }
            return m.request.get(endpoint, { "headers": headers })
        end function

        _joinGenres: function(genres as Object) as Object
            ' Create an associative array to store unique objects by their id
            uniqueObjects = {}

            ' Iterate over each array in the input array of arrays
            for each response in genres
                if response.ok
                    for each obj in response.json.genres
                        ' Check if the object id already exists in the uniqueObjects associative array
                        if NOT uniqueObjects.doesExist(obj.id.ToStr())
                            ' If not, add the object to the uniqueObjects associative array
                            uniqueObjects[obj.id.ToStr()] = obj
                        end if
                    end for
                end if
            end for

            ' Convert the uniqueObjects associative array back to a regular array
            resultArray = []
            for each key in uniqueObjects
                resultArray.push(uniqueObjects[key])
            end for

            return resultArray
        end function
    }

    this._init()
    return this
end function
