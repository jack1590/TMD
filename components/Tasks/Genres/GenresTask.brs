sub init()
end sub

sub execute()
    m.genresService = GenresService(m.global.config)
    response = m.genresService.getGenres()
    content = CreateObject("roSGNode", "ContentNode")
    if response.ok
        genres = response.json.genres
        for each item in genres
            genreNode = content.createChild("ContentNode")
            genreNode.update(item, true)
        end for
    end if
    m.top.responseNode = content
end sub
