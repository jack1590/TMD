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
    m.menuGrid.content = event.getData()
    m.menuGrid.setFocus(true)
end sub
