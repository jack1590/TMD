sub init()
    bindcomponents()
    registerObservers()
end sub

sub bindComponents()
    m.navigationManager = m.global.navigationManager
    m.gotToButton = m.top.findNode("gotToButton")
end sub

sub initialize(viewParams as Object)
    m.gotToButton.setFocus(true)
end sub

sub registerObservers()
    m.gotToButton.observeField("buttonSelected", "onButtonSelected")
end sub

sub onButtonSelected()
    m.navigationManager.callFunc("navigateTo", {
        "viewName": "details"
        "viewParams": {}
    })
end sub
