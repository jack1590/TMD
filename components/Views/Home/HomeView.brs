sub init()
    bindcomponents()
    registerObservers()
end sub

'|----------------------------------------------|
'|              Public Methods                 |
'|----------------------------------------------|
sub initialize(viewParams as Object)
    m.menu.setFocus(true)
    m.global.loading = true
    m.menu.callFunc("initialize")
end sub

'|----------------------------------------------|
'|              Private Methods                 |
'|----------------------------------------------|
sub bindComponents()
    m.menu = m.top.findNode("menu")
    m.contentRowList = m.top.findNode("contentRowList")
    m.contentTask = CreateObject("roSGNode", "ContentTask")
end sub

sub registerObservers()
    m.menu.observeField("itemSelected", "onMenuItemSelected")
    m.contentRowList.observeField("rowItemFocused", "onRowItemFocusedChanged")
    m.contentRowList.observeField("rowItemSelected", "onRowItemSelectedChanged")
end sub

sub loadAssetsByGenre(genreId as String)
    if m.contentTask.genreId <> genreId
        m.contentTask.unobserveField("response")
        m.contentTask.response = invalid
        m.global.loading = true
        m.contentRowList.content = invalid
    end if
    m.contentTask.genreId = genreId
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
    if m.contentRowList.content = invalid
        m.contentRowList.content = response.content
    else
        m.contentRowList.content.appendChildren(response.content.getChildren(-1, 0))
    end if
    m.global.loading = false
end sub

sub onRowItemFocusedChanged(event as Object)
    rowIndex = event.getData()
    if m.contentRowList.content.getChildCount() - rowIndex[0] <= 2
        m.global.loading = true
        m.contentTask.unobserveField("response")
        response = m.contentTask.response
        response.json.page++
        m.contentTask.response = response
        m.contentTask.observeField("response", "onContentChanged")
        m.contentTask.control = "RUN"
    end if
end sub

sub onRowItemSelectedChanged(event as Object)
    rowIndex = event.getData()
    content = m.contentRowList.content.getChild(rowIndex[0]).getChild(rowIndex[1])
    m.navigationManager.callFunc("navigateTo", {
        "viewName": "details"
        "viewParams": {
            content: content.getFields()
        }
    })
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
        else if (key = "up" OR key = "back") AND m.contentRowList.isInFocusChain()
            m.menu.setFocus(true)
            handled = true
        end if
    end if

    return handled
end function
