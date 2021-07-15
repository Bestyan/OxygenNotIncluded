; -------------------------------------------------
; roll dupes with a skill
; -------------------------------------------------

#IfWinActive Oxygen Not Included
; ctrl a - roll left dupe
^a::
    rollPositiveSkill(1, "handy1.png")
    return

#IfWinActive Oxygen Not Included
; ctrl s - roll middle dupe
^s::
    rollPositiveSkill(2, "handy2.png")
    return

#IfWinActive Oxygen Not Included
; ctrl d - roll right dupe
^d::
    rollPositiveSkill(3, "quicklearner3.png")
    return

; -------------------------------------------------
; roll dupes with interest and skill
; -------------------------------------------------

#IfWinActive Oxygen Not Included
; shift a - roll left dupe
+a::
    rollSkillAndInterest(1, "building_digging1.png", "handy1.png")
    return

#IfWinActive Oxygen Not Included
; shift s - roll middle dupe
+s::
    rollSkillAndInterest(2, "building_digging2.png", "handy2.png")
    return

; -------------------------------------------------
; utility hotkeys
; -------------------------------------------------

; shift c - get mouse coordinates in a msgbox
+c::
    MouseGetPos, mouseX, mouseY
    MsgBox, %mouseX% %mouseY%    ; reroll click coords 830|370 1200|370 1550|370
Return


rollPositiveSkill(position, image)
{
    clickX := (position = 1) ? 830 : (position = 2) ? 1200 : (position = 3) ? 1550 : 10
    xRange := getXRange(position)
    Loop {
        click(clickX, 370)
        skillFound := findImage(xRange[1], 795, xRange[2], 873, image) ; autohotkey starts indexing at 1
        if(skillFound){
            return
        }
    }
}

rollInterest(position, image)
{
    clickX := (position = 1) ? 830 : (position = 2) ? 1200 : (position = 3) ? 1550 : 10
    xRange := getXRange(position)
    Loop {
        click(clickX, 370)
        interestFound := findImage(xRange[1], 675, xRange[2], 755, image) ; autohotkey starts indexing at 1
        if(interestFound){
            return
        }
    }
}

rollSkillAndInterest(position, interestImage, skillImage)
{
    clickX := (position = 1) ? 830 : (position = 2) ? 1200 : (position = 3) ? 1550 : 10
    xRange := getXRange(position)
    Loop {
        click(clickX, 370)
        interestFound := findImage(xRange[1], 675, xRange[2], 755, interestImage) ; autohotkey starts indexing at 1

        if(interestFound){
            skillFound := findImage(xRange[1], 795, xRange[2], 873, skillImage) ; autohotkey starts indexing at 1
            if(skillFound){
                return
            }
        }

    }
}

; returns the left and right image x bound for the given position
getXRange(position)
{
    Switch position{
        Case 1:
            return [760, 1074]
        Case 2:
            return [1116, 1428]
        Case 3:
            return [1470, 1800]
        Default:
            MsgBox Forbidden position: %position%
            return
    }
}

click(x, y)
{
    Click, %x% %y%, Left
    Return
}

findImage(x1, y1, x2, y2, file)
{
    CoordMode Pixel  ; Interprets the coordinates below as relative to the screen rather than the active window.
    ImageSearch, foundX, foundY, x1, y1, x2, y2, *5 %file%
    if (ErrorLevel = 2) {
        MsgBox Could not conduct the image search.
        return True
    } else if (ErrorLevel = 1) {
        return False
    } else {
        return True
    }
}

Escape::
    ExitApp
Return