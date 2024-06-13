sub init()
    m.logger = Logger()
    m.name = m.top.subtype()
end sub

'|----------------------------------------------|
'|              Override Methods                |
'|----------------------------------------------|
sub initialize(viewparams as Object)
    m.logger.warn("method should be override", m.name)
end sub
