sub init()
    setupCoreComponents()
    setGlobalFields()
    initializeCoreComponents()
    m.navigationManager.callFunc("navigateTo", {
        "viewName": "home"
        "viewParams": {}
    })
    m.logger.info("App created", "MainScene")
end sub

sub setGlobalFields()
    m.global.addFields({
        navigationManager: m.navigationManager
        config: parseJson(ReadAsciiFile("pkg:/config/config.json"))
    })
end sub

sub setupCoreComponents()
    m.logger = Logger()
    m.navigationManager = m.top.findNode("navigationManager")
    m.menu = m.top.findNode("menu")
end sub

sub initializeCoreComponents()
    m.navigationManager.callFunc("initialize")
    m.menu.callFunc("initialize")
end sub
