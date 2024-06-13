sub init()
    bindcomponents()
    registerObservers()
end sub

'|----------------------------------------------|
'|              Public Methods                 |
'|----------------------------------------------|
sub initialize(viewParams as Object)
    m.menu.callFunc("initialize")
end sub

'|----------------------------------------------|
'|              Private Methods                 |
'|----------------------------------------------|
sub bindComponents()
    m.navigationManager = m.global.navigationManager
    m.menu = m.top.findNode("menu")
end sub

sub registerObservers()
    m.menu.observeField("itemSelected", "onMenuItemSelected")
end sub

sub loadAssetsByGenre(genreId as String)

end sub

'|----------------------------------------------|
'|              Callbacks Methods               |
'|----------------------------------------------|
sub onMenuItemSelected(event as Object)
    itemSelected = event.getData()
    if itemSelected?.id = invalid
        m.logger.error("Selected menu item is not valid", m.name, { menuItem: itemSelected })
        return
    end if

    m.logger.verbose("Loading information for genre", m.name, itemSelected)
    loadAssetsByGenre(itemSelected.id.toStr())
end sub
