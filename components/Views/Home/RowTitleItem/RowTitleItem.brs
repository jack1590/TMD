sub init()
    bindComponents()
    setStyles()
end sub

sub bindComponents()
    m.line = m.top.findNode("line")
    m.title = m.top.findNode("title")
end sub

sub setStyles()
    m.title = getFont("pkg:/fonts/HKGrotesk-Italic.otf", 26)
end sub

'Callbacks

'-------------
' onContentChanged()
'
' observes:
' <field> content in m.top
'-------------
sub onContentChanged(msg as Object)
    m.title.text = msg.getData().title
end sub
