sub init()
    bindComponents()
    registerObservers()
end sub

'|----------------------------------------------|
'|              Private Methods                 |
'|----------------------------------------------|

sub bindComponents()
    m.indexSelected = 0
    m.menuGrid = m.top.findNode("menuGrid")
    m.genresTask = CreateObject("roSGNode", "GenresTask")
    m.top.observeField("focusedChild", "onFocusChanged")
end sub

sub registerObservers()
    m.genresTask.observeField("responseNode", "onGenresChanged")
    m.menuGrid.observeField("itemSelected", "onItemSelectedChanged")
end sub

'|----------------------------------------------|
'|              Public Methods                  |
'|----------------------------------------------|

sub initialize()
    m.genresTask.control = "RUN"
end sub

'|----------------------------------------------|
'|              Callbacks Methods               |
'|----------------------------------------------|

sub onGenresChanged(event as Object)
    content = event.getData()
    m.menuGrid.content = content
    content = content.getChild(0).getFields()
    m.top.itemSelected = { id: content.id, name: content.name }
end sub

sub onItemSelectedChanged(event as Object)
    index = event.getData()
    if m.indexSelected = index then return 'Avoid load same content
    m.indexSelected = index
    content = m.menuGrid.content.getChild(index).getFields()
    m.top.itemSelected = { id: content.id, name: content.name }
end sub

sub onFocusChanged()
    if m.top.hasfocus() AND NOT m.menuGrid.hasFocus()
        m.menuGrid.setFocus(true)
    end if
end sub
