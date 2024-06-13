sub init()
    bindcomponents()
    registerObservers()
end sub

sub bindComponents()
    m.navigationManager = m.global.navigationManager
    m.menu = m.top.findNode("menu")
end sub

sub initialize(viewParams as Object)
    m.menu.callFunc("initialize")
end sub

sub registerObservers()
    m.menu.observeField("itemSelected", "onMenuItemSelected")
end sub

'|----------------------------------------------|
'|              Callbacks Methods                  |
'|----------------------------------------------|
sub onMenuItemSelected(event as Object)
    itemSelected = event.getData()
end sub
