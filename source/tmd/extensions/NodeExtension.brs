function getFont(fontUri as String, fontSize as Integer) as Object
    font = createObject("roSGNode", "Font")
    font.size = fontSize
    font.uri = fontUri
    return font
end function

function getFocusNode(node) as Object
    focusNode = invalid
    if node <> invalid
        focusNode = node
        if focusNode.id <> focusNode.focusedChild.id AND m[focusNode.focusedChild.id] <> invalid
            return getFocusNode(focusNode.focusedChild)
        end if
    end if
    return focusNode
end function
