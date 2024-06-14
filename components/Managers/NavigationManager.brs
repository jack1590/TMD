sub init()
    m.name = m.top.subtype()
    m.viewStack = []
    m.viewport = m.top.findNode("viewPort")
    m.logger = Logger()
    m.viewMap = {
        home: {
            node: "HomeView"
        },
        details: {
            node: "DetailsView"
        }
    }
end sub

'---------
' initialize:
'---------
sub initialize()
    m.scene = m.top.getScene()
end sub

'---------
' navigateTo:
' Navigates to the next screen while keeping the current screen in the stack.
' This means that if there is a transition from view A to view B, view A remains in the background.
' @param {object} params - Parameters for the navigation.
'---------
sub navigateTo(params as Object)
    m.logger.info("Navigating to ", m.name, params)
    view = createView(params)
    if view <> invalid
        m.viewStack.push(view)
        appendToViewport(view)
        view.callFunc("initialize", params.viewParams)
    end if
end sub

function getCurrentScreen()
    currentScreen = invalid
    if m.viewPort.getChildCount() > 0
        currentScreen = m.viewPort.getChild(0)
    end if
    return currentScreen
end function

'---------
' goToPrevious:
' Navigates to the previous view in the stack.
'
' @returns {boolean} - Returns true if navigation to the previous view was successful, otherwise returns false.
'
' If there is only one or no views in the stack, logs a warning and returns false.
' Otherwise, removes the current view from the stack, navigates to the previous view,
' appends it to the viewport, and calls its update function.
'---------
sub goToPrevious() as Boolean
    if m.viewStack.count() <= 1
        m.logger.warn("No more views in stack ", m.name)
        return false
    else
        m.viewStack.pop()
        previousView = m.viewStack.peek()
        appendToViewport(previousView)
        previousView.callFunc("update")
        return true
    end if
end sub

'---------
' createView:
' Creates and returns a view node based on the provided parameters.
'
' @param {object} params - The parameters for creating the view. Must contain:
'   - viewName: The name of the view to be created.
'
' @returns {object} - The created view node if successful, otherwise returns invalid.
'---------
sub createView(params as Object) as Object
    if params <> invalid AND params.viewName <> invalid
        viewNode = m.viewMap[params.viewName]?.node
        if viewNode <> invalid
            view = createObject("roSGNode", viewNode)
            if view <> invalid
                view.id = params.viewName
                return view
            end if
        end if
    end if
    return invalid
end sub

'---------
' appendToViewPort:
' Appends a view to the viewport. If the viewport already contains a child, it replaces the existing child with the new view.
'
' @param {object} view - The view object to be appended or replaced in the viewport.
'---------
sub appendToViewPort(view as Object)
    if m.viewPort.getChildCount() > 0
        m.viewPort.replaceChild(view, 0)
    else
        m.viewPort.appendChild(view)
    end if
    view.setFocus(true)
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    if press
        if key = "back"
            handled = goToPrevious()
        end if
    end if
    return handled
end function
