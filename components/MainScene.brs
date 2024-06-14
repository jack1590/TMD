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
        loading: false
    })
    m.global.observeFieldScoped("loading", "onLoadingFlagChanged")
end sub

sub setupCoreComponents()
    m.logger = Logger()
    m.navigationManager = m.top.findNode("navigationManager")
    m.spinner = m.top.findNode("spinner")
    setSpinnerStyle()
end sub

sub setSpinnerStyle()
    m.spinner.setFields({
        "translation": [
            916,
            496
        ],
        "loadDisplayMode": "scaleToFill"
        "loadWidth": 87,
        "loadHeight": 87,
        "visible": false
    })
    m.spinner.poster.uri = "pkg:/images/spinner.png"
end sub

sub initializeCoreComponents()
    m.navigationManager.callFunc("initialize")
end sub

sub onLoadingFlagChanged()
    loading = m.global.loading
    m.spinner.visible = loading
    if loading
        m.spinner.setFocus(true)
    else
        currentScreen = m.navigationManager.callFunc("getCurrentScreen")
        if currentScreen <> invalid
            currentScreen.setFocus(true)
        end if
    end if
end sub
