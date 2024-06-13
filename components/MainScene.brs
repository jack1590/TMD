sub init()
    createCoreComponents()
    setGlobalFields()
    m.logger.info("App created", "MainScene")
    m.navigationManager.callFunc("navigateTo", {
        "viewName": "home"
        "viewParams": {}
    })
end sub

sub setGlobalFields()
    m.global.addFields({ navigationManager: m.navigationManager })
end sub

sub createCoreComponents()
    m.logger = Logger()
    m.navigationManager = m.top.findNode("navigationManager")
    m.navigationManager.callFunc("initialize")
end sub
