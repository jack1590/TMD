sub init()
    m.genresService = GenresService(m.global.config)
end sub

sub execute()
    genres = m.genresService.getGenres()
    content = CreateObject("roSGNode", "ContentNode")
    for each item in genres
        genreNode = content.createChild("ContentNode")
        genreNode.update(item, true)
    end for
    m.top.responseNode = content
end sub
