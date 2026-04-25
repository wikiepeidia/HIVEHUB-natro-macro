#Requires AutoHotkey v2.0
#SingleInstance Force

macroFile := A_ScriptDir "\natro_macro.ahk" ; Renamed to avoid AHK v2 'File' class conflict

if !FileExist(macroFile) {
    MsgBox "natro_macro.ahk not found in this directory.", "Error", 16
    ExitApp
}

content := FileRead(macroFile)

; Fix 1: Petal Tabbouleh - Pineapple -> Cactus
; (?s) allows searching across multiple lines. We anchor to the quest name, then target Pineapple.
content := RegExReplace(content, "(?s)(`"Petal Tabbouleh`".*?\[1,\s*`"Collect`",\s*`")Pineapple(`")", "${1}Cactus$2")

; Fix 2: Mashed Blooms - Bamboo -> Pineapple
content := RegExReplace(content, "(?s)(`"Mashed Blooms`".*?\[3,\s*`"Collect`",\s*`")Bamboo(`")", "${1}Pineapple$2")

FileDelete macroFile
FileAppend content, macroFile

MsgBox "Regex patch complete!`nDeath to the Pineapple field for green petals!", "Success", 64
ExitApp