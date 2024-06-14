sub execute()
    currentData = m.top.response?.json
    m.page = 1
    if currentData?.page <> invalid then m.page = currentData?.page
    m.contentService = ContentService(m.global.config)
    response = m.contentService.getContentByGenreId(m.top.genreId, m.page)
    if response.ok
        response.content = createContent(response.json.results)
    end if
    m.top.response = response
end sub

function createContent(movies as Object) as Object
    offset = 5 * (m.page - 1)
    content = CreateObject("roSGNode", "ContentNode")
    section = invalid
    for i = 0 to movies.count() - 1
        movie = movies[i]
        if i mod 4 = 0
            section = content.createChild("ContentNode")
            section.title = "Row " + ((i / 4) + 1 + offset).toStr()
        end if
        item = section.createChild("ContentNode")
        item.setFields({
            "id": movie.id
            "Title": movie.title
            "Description": movie.overview
            "FHDPosterUrl": movie.backdrop_path
            "ReleaseDate": movie.release_date
        })
    end for
    return content
end function
