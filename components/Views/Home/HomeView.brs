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
    m.contentRowList = m.top.findNode("contentRowList")
    m.contentTask = CreateObject("roSGNode", "ContentTask")
end sub

sub registerObservers()
    m.menu.observeField("itemSelected", "onMenuItemSelected")
end sub

sub loadAssetsByGenre(genreId as String)
    m.contentTask.observeField("response", "onContentChanged")
    m.contentTask.control = "RUN"
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

sub onContentChanged(event as Object)
    response = event.getData()
    m.contentRowList.content = response.content
end sub


'|----------------------------------------------|
'|              Native Methods                  |
'|----------------------------------------------|

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    if press
        if key = "down" AND m.menu.isInFocusChain()
            m.contentRowList.setFocus(true)
            handled = true
        else if key = "up" AND m.contentRowList.isInFocusChain()
            m.menu.setFocus(true)
            handled = true
        end if
    end if

    return handled
end function
