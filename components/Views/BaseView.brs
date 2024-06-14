sub init()
    bindBaseComponents()
    registerBaseObservers()
end sub

sub bindBaseComponents()
    m.logger = Logger()
    m.name = m.top.subtype()
    m.defaultFocusId = ""
end sub

sub registerBaseObservers()
    m.top.observeFieldScoped("focusedChild", "onFocusChanged")
end sub

'|----------------------------------------------|
'|              Override Methods                |
'|----------------------------------------------|
sub initialize(viewparams as Object)
    m.logger.warn("method should be override", m.name)
end sub


sub onFocusChanged(event as Object)
    ' Save previous focus
    focusNode = getFocusNode(event.getData())
    if focusNode <> invalid AND m[focusNode.id] <> invalid AND m.defaultFocusId <> focusNode.id
        m.defaultFocusId = focusNode.id
    end if
    if m.top.hasFocus() AND m.defaultFocusId <> "" AND m[m.defaultFocusId] <> invalid
        m[m.defaultFocusId].setFocus(true)
    end if
end sub
