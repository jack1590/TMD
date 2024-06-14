
sub init()
    bindcomponents()
    setStyles()
end sub

'|----------------------------------------------|
'|              Public Methods                  |
'|----------------------------------------------|
sub initialize(viewParams as Object)
    content = viewParams.content
    m.global.loading = true
    m.title.text = content.title
    m.subtitle.text = content.releaseDate
    m.description.text = content.description
    uri = Substitute(m.global.config.imageEndpoint, "w" + (500).toStr(), content.FHDPosterUrl)
    if content.FHDPosterUrl = "" then uri = "pkg:/images/failedImage.jpeg"
    m.moviePoster.setFields({
        loadDisplayMode: "scaleToFit"
        loadWidth: 900
        loadHeight: 1000
        uri: uri
    })
    m.global.loading = false
end sub

'|----------------------------------------------|
'|              Private Methods                 |
'|----------------------------------------------|
sub bindComponents()
    m.title = m.top.findNode("title")
    m.subtitle = m.top.findNode("subtitle")
    m.description = m.top.findNode("description")
    m.moviePoster = m.top.findNode("moviePoster")
end sub

sub setStyles()
    m.title.font = getFont("pkg:/fonts/HKGrotesk-Bold.otf", 50)
    m.subtitle.font = getFont("pkg:/fonts/HKGrotesk-Light.otf", 40)
    m.description.font = getFont("pkg:/fonts/HKGrotesk-Regular.otf", 32)
end sub

'|----------------------------------------------|
'|              Native Methods                  |
'|----------------------------------------------|

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    if press
        if key = "back"
            m.navigationManager.callFunc("goToPrevious")
            handled = true
        end if
    end if

    return handled
end function
