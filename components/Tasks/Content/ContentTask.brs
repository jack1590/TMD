sub execute()
    m.contentService = ContentService(m.global.config)
    response = m.contentService.getContentByGenreId("")

    m.top.response = response
end sub
