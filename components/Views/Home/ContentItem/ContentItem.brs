sub init()
    bindComponents()
    setStyles()
end sub

sub bindComponents()
    m.poster = m.top.findNode("poster")
    m.title = m.top.findNode("title")
    m.description = m.top.findNode("description")
end sub

sub setStyles()
    m.description.font = getFont("pkg:/fonts/HKGrotesk-Regular.otf", 26)
    m.title.font = getFont("pkg:/fonts/HKGrotesk-Regular.otf", 26)
end sub

'|----------------------------------------------|
'|              Callbacks Methods               |
'|----------------------------------------------|

'-------------
' onItemContentChanged()
'
' observes:
' <field> itemContent in m.top
'-------------
sub onItemContentChanged(event as Object)
    itemContent = event.getData()
    width = m.top.width
    height = m.top.height
    m.title.width = width
    m.description.width = height
    m.title.text = itemContent.title
    m.description.text = itemContent.ReleaseDate
    roundedValue = (width + 99) \ 100 * 100
    uri = Substitute(m.global.config.imageEndpoint, roundedValue.toStr(), itemContent.FHDPosterUrl)
    m.poster.observeField("loadStatus", "onLoadStatusChanged")
    m.poster.setFields({
        loadDisplayMode: "limitSize"
        loadWidth: width
        loadHeight: height - 70
        uri: uri
    })
end sub

sub onLoadStatusChanged(event as Object)
    state = event.getData()
    if state = "failed"
        print "onLoadStatusChanged ";event.getRoSGNode().uri
    end if
end sub
