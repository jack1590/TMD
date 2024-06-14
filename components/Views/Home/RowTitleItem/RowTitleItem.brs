sub init()
    bindComponents()
    setStyles()
end sub

'|----------------------------------------------|
'|              Private Methods                 |
'|----------------------------------------------|

sub bindComponents()
    m.line = m.top.findNode("line")
    m.title = m.top.findNode("title")
end sub

sub setStyles()
    m.title.font = getFont("pkg:/fonts/HKGrotesk-Italic.otf", 26)
end sub

'|----------------------------------------------|
'|              Callbacks Methods               |
'|----------------------------------------------|

'-------------
' onContentChanged()
'
' observes:
' <field> content in m.top
'-------------
sub onContentChanged(msg as Object)
    m.title.text = msg.getData().title
end sub
