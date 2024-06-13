function getFont(fontUri as String, fontSize as Integer) as Object
    font = createObject("roSGNode", "Font")
    font.size = fontSize
    font.uri = fontUri
    return font
end function
