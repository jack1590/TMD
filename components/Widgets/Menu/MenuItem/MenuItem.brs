sub init()
    bindComponents()
    setStyle()
end sub

sub bindComponents()
    m.name = m.top.findNode("name")
    m.border = m.top.findNode("border")
end sub

sub setStyle()
    m.name.font = getFont("pkg:/fonts/HKGrotesk-Bold.otf", 30)
end sub

sub showcontent()
    itemcontent = m.top.itemContent
    m.name.text = itemcontent.name
end sub

sub showfocus()
    m.border.opacity = m.top.focusPercent
end sub
