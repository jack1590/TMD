sub init()
end sub

sub execute()
    m.genresService = GenresService(m.global.config)
    genres = m.genresService.getGenres()
    content = CreateObject("roSGNode", "ContentNode")
    for each item in genres
        genreNode = content.createChild("ContentNode")
        genreNode.update(item, true)
    end for
    m.top.responseNode = content
end sub
