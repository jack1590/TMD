sub init()
    bindComponents()
    registerObservers()
end sub

sub bindComponents()
    m.menuGrid = m.top.findNode("menuGrid")
    m.genresTask = CreateObject("roSGNode", "GenresTask")
end sub

sub registerObservers()
    m.genresTask.observeField("responseNode", "onGenresChanged")
end sub

sub initialize()
    m.genresTask.control = "RUN"
end sub

sub onGenresChanged(event as Object)
    content = event.getData()
    m.menuGrid.content = content
    m.menuGrid.setFocus(true)
    content = content.getChild(0).getFields()
    m.top.itemSelected = { id: content.id, name: content.name }
end sub
