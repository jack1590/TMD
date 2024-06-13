sub init()
    m.name = m.top.subtype()
    m.logger = Logger()
    m.top.functionName = "execute"
    m.request = Requests()
end sub
