SendMode Input
;SetBatchLines -1
#NoEnv
#SingleInstance Force
#MaxHotkeysPerInterval, 200
SetDefaultMouseSpeed, 0
SetMouseDelay, 0
CoordMode, Screen


scriptActive := 1
afkActive := 0
startX := 0
startY := 0
radius := 50
pi := 3.141592

/* TODO
// Do red and green circles with GUI or smt
// when afk display green
// when moved display red momentarily
*/

; Gui, 1: -Caption +E0x80000 +LastFound +AlwaysOnTop +ToolWindow +OwnDialogs
; Gui, 1: Show, NA
; hwnd1 := WinExist()
; hmb := CreateDIBSection(radius + 5, radius + 5)
; hdc := CreateCompatibleDC()
; obm := SelectObject(hdc, hdm)
; G := Gdip_GraphicsFromHDC(hdc)
; Gdip_SetSmoothingMode(G, 4)
; pBrush := Gdip_BrushCreateSolid(0xffff0000)
; Gdip_FillEllipse(G, pBrush, 5, 10, 50, 50)
; Gdip_DeleteBrush(pBrush)



#MaxThreadsPerHotkey 2
f11::	
	radian := 0
	afkActive := !afkActive
	MouseGetPos, startX, StartY
	
	if (afkActive) ; at least get mouse into position before checking if mouse moved
	{
		MouseMove, startX + Cos(radian) * radius, startY + Sin(-radian) * radius
		radian += pi / 100
	}
	while(afkActive) {
		MouseGetPos, testX, testY
		CalcCoord := sqrt((testX - startX)**2 + (testY - startY)**2)
		; Msgbox, % testX . " " . startX . " " . testY . " " . startY . "`n"
				; . calcCoord . " " . radius
		if (calcCoord > radius + 2 || calcCoord < radius - 2) ; check mouse here so it can be used with a sleep
		{
			afkActive := 0
			Return
		}
	
		MouseMove, startX + Cos(radian) * radius, startY + Sin(-radian) * radius ; sin(minus( because i want to move it anti clockwise like cartesian coord system
		radian += pi / 100 ; move the mouse then increment the radians
		
		;msgbox, % radian . " " . pi . " " . Mod(radian, pi)
		if (Mod(radian, pi) <= 0.0001) ; check whether to click or not
		{
			Send, {LButton}
		}
		
		Sleep, 10
	}
Return

*~SC029::
	Suspend, Off
	if scriptActive = 0
	{
		scriptActive := 1
		;SoundPlay, C:\Windows\Media\Speech On.wav
		KeyWait, SC029
		Suspend, Off
		}
	Else
	{
		scriptActive = 0
		;SoundPlay, C:\Windows\Media\Speech Off.wav
		KeyWait, SC029
		Suspend, On
		}
Return


*~f12::
	Suspend, Off
ExitApp