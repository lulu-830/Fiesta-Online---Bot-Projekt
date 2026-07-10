#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Res_Comment=2 Starts Version
#AutoIt3Wrapper_Res_Description=Fiesta Online Bot
#AutoIt3Wrapper_Res_Fileversion=0.1.0.0
#AutoIt3Wrapper_Res_File_Add=screen.jpg
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ***

#RequireAdmin
SetPrivilege ( "SeDebugPrivilege" ,  1 )

#include <GUIConstantsEx.au3>
#include <GUIEdit.au3>
#include <NomadMemory.au3>
#include "KDMemory.au3"


;Opt("WinWaitDelay", 100)		;
;Opt("WinTitleMatchMode", 4)		;
;Opt("WinDetectHiddenText", 1)	;

Dim $posora[2], $posgruen[2], $poslila[2], $posstri[2]
$target=""
$i=2
$c=2
$pos=""
$STR=""
Dim $leben[2]					; Array momentanes Leben
Dim $mana[2]					; Array momentanes Mana
Dim $maxleben[2]				; Array momentanes MaxLeben
Dim $manamax[2]				; Array momentanes MaxLeben
$char = "1"
$min_SP   = 0
$min_HP   = 0
$min_HP2  = 0
$hp_Stein = 0
$sp_Stein = 0
$hp_pot   = 0
$C   = 0
$x   = 0
$y   = 0
$x2   = 0
$y2   = 0
$pick	= 0
$erzfarbe	= 0
$gegnerfarbe	= 0
$ex1	= 0
$ex2	= 0
$ey1	= 0
$ey2	= 0
$gx1	= 0
$gy1	= 0




Const $offsets[3]  = [552, 376, 300] ; Pointer in Dezimal für Heal
Const $offsets1[3] = [552, 376, 304] ; Pointer in Dezimal für Heal
Const $offsets2[3] = [552, 380, 300] ; Pointer in Dezimal für MaxHp
Const $offsets3[3] = [552, 380, 304]
$farbe = 0x00bfff
$Schriftfarbe = 0x000000

$Pickup =0						; für die Main Schleife

_Load ()						; Funktion - Ini Einlesen

$process = "Fiesta.exe"
$processId = ProcessExists($process)
$handles = _KDMemory_OpenProcess($processId)
$moduleBaseAddress = _KDMemory_GetModuleBaseAddress($handles, $process)
$baseAddress = $moduleBaseAddress + 0x0066F1D0
$baseAddress2 = $moduleBaseAddress + 0x0075BF0C

$leben = _KDMemory_ReadProcessMemory($handles, $baseAddress, "FLOAT", $offsets)
$mana  = _KDMemory_ReadProcessMemory($handles, $baseAddress, "FLOAT", $offsets2)
$manamax = _KDMemory_ReadProcessMemory($handles, $baseAddress, "FLOAT", $offsets3)
$maxleben = _KDMemory_ReadProcessMemory($handles, $baseAddress, "FLOAT", $offsets1)

$hGUI = GUICreate('Waschbär bot', 361, 575, @DesktopWidth - 820) 	; Fenster erstellen (Name,x,y, xpos start? )
$hPic = GUICtrlCreatePic( "Screen.jpg", 0, 0, 361, 188) ; Bild Laden

GUISetBkColor("0x" & $Farbe)											;
GUICtrlSetDefBkColor("0x" & $Farbe)									;
GUICtrlSetDefColor("0x" & $Schriftfarbe)

$hEdit = GUICtrlCreateEdit('', 0, 440, 360, 100, BitOR($ES_AUTOVSCROLL, $ES_READONLY, $ES_WANTRETURN)) ; LOG Fenster
;_GUICtrlEdit_SetLimitText($hEdit, 1000000000000000000000000000000000000000000000000000000000000)

_Ausgabe ()

AutoItSetOption('SendKeyDownDelay', 70)							;

HotKeySet("{F9}", "starten"); Bot starten
HotKeySet("{F10}", "Pause")	; Bot pause
HotKeySet("{F11}", "ende")	; Bot beenden


$hCheckbox1 = GUICtrlCreateCheckbox('', 32, 200, 17, 17) ; Checkbox Autoheal
$hCheckbox2 = GUICtrlCreateCheckbox('', 32, 220, 17, 17) ; Checkbox Automana
$hCheckbox3 = GUICtrlCreateCheckbox('', 32, 240, 17, 17) ; Checkbox Automana
$hCheckbox4 = GUICtrlCreateCheckbox('', 32, 260, 17, 17) ; Checkbox Automana
$hCheckbox5 = GUICtrlCreateCheckbox('', 32, 280, 17, 17) ; Checkbox Automana
$hCheckbox6 = GUICtrlCreateCheckbox('', 130, 260, 17, 17) ; Checkbox Automana
$hCheckbox7 = GUICtrlCreateCheckbox('', 130, 280, 17, 17) ; Checkbox Automana
$hCheckbox8 = GUICtrlCreateCheckbox('', 130, 300, 17, 17) ; Checkbox Automana

$hButton1 = GUICtrlCreateButton('Autoheal',   5, 385, 70, 25) ; Button darstellen
$hButton2 = GUICtrlCreateButton('Automana',   5, 410, 70, 25) ; Button darstellen
$hButton3 = GUICtrlCreateButton('AutoPot',   5, 360, 70, 25) ; Button darstellen
$hButton4 = GUICtrlCreateButton('Strich-Bot',   5, 335, 70, 25) ; Button darstellen
$hButton5 = GUICtrlCreateButton('AutoPickup',   5, 310, 70, 25) ; Button darstellen
$hButton6 = GUICtrlCreateButton('Auto Miner',   85, 410, 70, 25) ; Button darstellen

GUISetState(@SW_SHOW)					;


_log('Bot bereit')				; Ausgabe ins Status-Fenster

_log('Momentane HP : ' & $leben[$char]); Ausgabe ins Status-Fenster
_log('Momentane Sp : ' & $mana[$char])	; Ausgabe ins Status-Fenster
_log('max Sp : ' & $manamax[$char])	; Ausgabe ins Status-Fenster
_log('Momentane Max HP : ' & $maxleben[$char])	; Ausgabe ins Status-Fenster
_log('HP verloren: ' & $maxleben[$char] - $leben[$char])	; Ausgabe ins Status-Fenster
_log('Bot bereit')				; Ausgabe ins Status-Fenster
 While $Pickup = 0												; Mainschleife


Switch GUIGetMsg()
		 Case $GUI_EVENT_CLOSE
		 Exit
		 Case $hButton1																									; HP angeklickt
			_log ('Autoheal Einstellungen')																				; Ausgabe Statusfenster
			$taste = InputBox("Autoheal Einstellungen","Deine Taste für HP Stein bitte:", "Q")							; Wertabfrage
			$hp_stein=$taste																						; Wertübergabe
			$taste = InputBox("Autoheal Einstellungen","Bei wieviel HP Verlust soll ein HP Stein genommen werden :", "1500"); Wertabfrage
			$min_HP=$taste																						; Wertübergabe
			$hLabel1 = GUICtrlCreateLabel(' Autoheal	mit Taste: ' & $hp_stein & '  -  HP-Stein nehmen bei : ' & $min_HP, 50, 200, 500, 21); Textausgabe

		Case $hButton2																									; SP angeklickt
			_log ('Automana Einstellungen')																				; Ausgabe Statusfenster
			$taste = InputBox("Automana Einstellungen","Deine Taste für SP Stein bitte:", "E")							; Wertabfrage
			$sp_stein=$taste																						; Wertübergabe
			$taste = InputBox("Automana Einstellungen","Bei wieviel Rest-SP soll ein SP Stein genommen werden :", "10000"); Wertabfrage
			$min_SP=$taste																						; Wertübergabe
			$hLabel2 = GUICtrlCreateLabel(' Automana	mit Taste: ' & $sp_stein & '  -  SP-Stein nehmen bei  : ' & $min_SP, 50, 220, 500, 21); Textausgabe

        Case $hButton3																									; SP angeklickt
			_log ('AutoPot Einstellungen')																				; Ausgabe Statusfenster
			$taste = InputBox("AutoPot Einstellungen","Deine Taste für HP Pot bitte:", "1")							; Wertabfrage
			$hp_pot=$taste																						; Wertübergabe
			$taste = InputBox("AutoPot Einstellungen","Bei wieviel HP Verlust soll ein HP Pot genommen werden :", "4000"); Wertabfrage
			$min_HP2=$taste																						; Wertübergabe
			$hLabel3 = GUICtrlCreateLabel(' AutoPot	mit Taste: ' & $hp_pot & '  -  HP-Pot nehmen bei  : ' & $min_HP2, 50, 240, 500, 21); Textausgabe

		Case $hButton4																									; SP angeklickt
			_log ('Strich Bot Einstellungen')																				; Ausgabe Statusfenster
			$taste = InputBox("Farb Code", "Farb Code", "0xFBFF29")							; Wertabfrage
			$c=$taste																						; Wertübergabe
			$taste = InputBox("Erster x - Wert", "Erster x - Wert", "914"); Wertabfrage
			$x=$taste																						; Wertübergabe
			$taste = InputBox("Erster y - Wert", "Erster y - Wert", "756"); Wertabfrage
			$y=$taste
			$taste = InputBox("Zweiter x - Wert", "Zweiter x - Wert", "1005"); Wertabfrage
			$x2=$taste																						; Wertübergabe
			$taste = InputBox("Zweiter y - Wert", "Zweiter y - Wert", "756"); Wertabfrage
			$y2=$taste

			Case $hButton5 																								; SP angeklickt
			_log ('Pickup Bot Einstellungen')																				; Ausgabe Statusfenster
			$taste = InputBox("Pickup Taste", "Pickup Taste", "2")							; Wertabfrage
			$pick=$taste																						; Wertübergabe

			Case $hButton6																									; SP angeklickt
			_log ('Auto Miner Einstellungen')																				; Ausgabe Statusfenster
			$taste = InputBox("Erzfarbe", "Farb Code", "0x881206")							; Wertabfrage
			$erzfarbe=$taste																						; Wertübergabe
			$taste = InputBox("Ziel Farbe", "Farbcode(Stern)", "0xFF5573"); Wertabfrage
			$gegnerfarbe=$taste																						; Wertübergabe
			$taste = InputBox("Erster x - Wert", "Erster x - Wert", "400"); Wertabfrage
			$ex1=$taste
			$taste = InputBox("Erster y - Wert", "Erster y - Wert", "400"); Wertabfrage
			$ey1=$taste																						; Wertübergabe
			$taste = InputBox("Zweiter x - Wert", "Zweiter x - Wert", "1000"); Wertabfrage
			$ex2=$taste
			$taste = InputBox("Zweiter y - Wert", "Zweiter y - Wert", "1000"); Wertabfrage
			$ey2=$taste
			$taste = InputBox("Ziel x - Wert", "Ziel x - Wert", "1015"); Wertabfrage
			$gx1=$taste
			$taste = InputBox("Ziel y - Wert", "Ziel y - Wert", "36"); Wertabfrage
			$gy1=$taste

EndSwitch
 WEnd							; und weiter Mainschleife

Func STARTEN()													; F9 würde gedrückt

WinActivate("FiestaOnline")

While (1)												; Schleife

	If GUICtrlRead($hCheckbox1) = 1 Then 				; Ist die Checkbock angeklickt ? Leben
		$leben = _KDMemory_ReadProcessMemory($handles, $baseAddress2, "FLOAT", $offsets)
		$maxleben = _KDMemory_ReadProcessMemory($handles, $baseAddress, "FLOAT", $offsets1)	;		MsgBox(1,"11", $leben)
		If ($maxleben[$char] - $leben[$char]) > $min_HP Then			; ist Leben < min_HP ?
 			Send("q")						; ja, dann HP-Stein nehmen
			_log('Momentane HP : ' & $leben[$char]) ; Ausgabe ins Status-Fenster
		EndIf											; Ende der Abfrage
	EndIf												; Ende der Abfrage

		If GUICtrlRead($hCheckbox1) = 1 Then 				; Ist die Checkbock angeklickt ? Leben
		$leben = _KDMemory_ReadProcessMemory($handles, $baseAddress2, "FLOAT", $offsets)
		$maxleben = _KDMemory_ReadProcessMemory($handles, $baseAddress, "FLOAT", $offsets1)
		If ($maxleben[$char] - $leben[$char]) > $min_HP2 Then			; ist Leben < min_HP ?
 			Send("1")						; ja, dann HP-Stein nehmen
			_log('Momentane HP : ' & $leben[$char]) ; Ausgabe ins Status-Fenster
		EndIf											; Ende der Abfrage
	EndIf

	If GUICtrlRead($hCheckbox3) = 1 Then				; Ist die Checkbock angeklickt ? Mana
		$mana  = _KDMemory_ReadProcessMemory($handles, $baseAddress, "FLOAT", $offsets2)
        $manamax = _KDMemory_ReadProcessMemory($handles, $baseAddress, "FLOAT", $offsets3)
		If $mana[$char] < $min_SP Then		; ist Leben < min_HP ?
			Send("e")						; ja, dann HP-Stein nehmen
			_log('Momentane SP : ' & $mana[$char]) ; Ausgabe ins Status-Fenster
		EndIf										; Ende der Abfrage
	EndIf												; Ende der Schleife

		If GUICtrlRead($hCheckbox4) = 1 Then				; Ist die Checkbock angeklickt ? Mana
		$STR = PixelSearch($x, $y, $x2, $y2,$c,2)
	    If IsArray($STR) = True Then
		;$pos=MouseGetPos()
		;Sleep(20)
		MouseMove($STR [0], $STR [1],0)
		MouseClick("left", $STR [0], $STR [1], 1, 0)
		MouseMove(1000, 500,0)
		;MouseMove($pos[0],$pos[1],0)									; Ende der Abfrage
		EndIf
	EndIf

	If GUICtrlRead($hCheckbox5) = 1 Then 				; Ist die Checkbock angeklickt ? Leben
		Send($pick)
	EndIf											; Ende der Abfrage

	If GUICtrlRead($hCheckbox6) = 1 Then 				; Ist die Checkbock angeklickt ? Leben
		$target = PixelGetColor( $gx1  , $gy1 )
	    if $target = $gegnerfarbe then
		Sleep(500)
		Else
		Call ("ZielSuchen")										; Ende der Abfrage
		EndIf
	Endif

		If GUICtrlRead($hCheckbox7) = 1 Then 				; Ist die Checkbock angeklickt ? Leben
		HotKeySet("{F1}", "deaggro")
		Endif

		If GUICtrlRead($hCheckbox8) = 1 Then 				; Ist die Checkbock angeklickt ? Leben
		Call ("swap")
		Endif

  WEnd													; Ende der Hauptschleife
EndFunc

Func _log($sString)												; Funktion für Ausgaben im Statusfenster
	_GUICtrlEdit_AppendText($hEdit, @HOUR & ':' & @MIN & ':' & @SEC & ' - ' & $sString & @CRLF) ; Fensterausgabe
	_GUICtrlEdit_LineScroll($hEdit, 0, _GUICtrlEdit_GetLineCount($hEdit)) ; Zeilenvorschub
EndFunc   												; Ende der Funktion

Func _Ausgabe ()												; Funktion der Haupt-Bildschirmausgabe
$hLabel1 = GUICtrlCreateLabel(' Autoheal	mit Taste: ' & $hp_stein & '  -  HP-Stein nehmen bei : ' & $min_HP, 50, 200, 500, 21)	; Textausgabe
$hLabel2 = GUICtrlCreateLabel(' Automana	mit Taste: ' & $sp_stein & '  -  SP-Stein nehmen bei  : ' & $min_SP, 50, 220, 500, 21)	; Textausgabe
$hLabel3 = GUICtrlCreateLabel(' AutoPot	mit Taste: ' & $hp_pot & '  -  Hp-Pot nehmen bei  : ' & $min_HP2, 50, 240, 500, 21)	; Textausgabe
$hLabel4 = GUICtrlCreateLabel(' Strich-Bot', 50, 260, 50, 21)	; Textausgabe
$hLabel5 = GUICtrlCreateLabel(' Pickup-Bot', 50, 280, 80, 21)	; Textausgabe
$hLabel6 = GUICtrlCreateLabel(' Auto Miner', 150, 260, 500, 21)	; Textausgabe
$hLabel6 = GUICtrlCreateLabel(' Deaggro', 150, 280, 500, 21)	; Textausgabe
$hLabel8 = GUICtrlCreateLabel(' detoswap', 150, 300, 500, 21)	; Textausgabe
$hLabel7 = GUICtrlCreateLabel('   (F9) Starten   -   (F10) Pause   -   (F11) Ende', 30, 550, 250, 21)
EndFunc

Func _Load ()													; Ini einladen
$min_SP             	=IniRead("FLB.ini","Char_1","Wert1","")
$min_HP             	=IniRead("FLB.ini","Char_1","Wert2","")
$min_HP2             	=IniRead("FLB.ini","Char_1","Wert3","")
$hp_Stein           	=IniRead("FLB.ini","Char_1","Wert4","")
$sp_Stein           	=IniRead("FLB.ini","Char_1","Wert5","")
$hp_pot					=IniRead("FLB.ini","Char_1","Wert6","")
$c             	        =IniRead("FLB.ini","Char_1","Wert7","")
$x            			=IniRead("FLB.ini","Char_1","Wert8","")
$y            			=IniRead("FLB.ini","Char_1","Wert9","")
$x2           			=IniRead("FLB.ini","Char_1","Wert10","")
$y2            			=IniRead("FLB.ini","Char_1","Wert11","")
$pick            		=IniRead("FLB.ini","Char_1","Wert12","")
$erzfarbe				=IniRead("FLB.ini","Char_1","Wert13","")
$gegnerfarbe			=IniRead("FLB.ini","Char_1","Wert14","")
$ex1					=IniRead("FLB.ini","Char_1","Wert15","")
$ex2					=IniRead("FLB.ini","Char_1","Wert16","")
$ey1					=IniRead("FLB.ini","Char_1","Wert17","")
$ex2					=IniRead("FLB.ini","Char_1","Wert18","")
$gx1					=IniRead("FLB.ini","Char_1","Wert19","")
$gy1					=IniRead("FLB.ini","Char_1","Wert20","")


EndFunc

Func _Save ()                                                   ; Ini speichern
	IniWrite("FLB.ini","Char_1","Wert1",$min_SP)
	IniWrite("FLB.ini","Char_1","Wert2",$min_HP)
	IniWrite("FLB.ini","Char_1","Wert3",$min_HP2)
	IniWrite("FLB.ini","Char_1","Wert4",$hp_stein)
	IniWrite("FLB.ini","Char_1","Wert5",$sp_Stein)
	IniWrite("FLB.ini","Char_1","Wert6",$hp_pot)
	IniWrite("FLB.ini","Char_1","Wert7",$c)
	IniWrite("FLB.ini","Char_1","Wert8",$x)
	IniWrite("FLB.ini","Char_1","Wert9",$y)
	IniWrite("FLB.ini","Char_1","Wert10",$x2)
	IniWrite("FLB.ini","Char_1","Wert11",$y2)
	IniWrite("FLB.ini","Char_1","Wert12",$pick)
	IniWrite("FLB.ini","Char_1","Wert13",$erzfarbe)
	IniWrite("FLB.ini","Char_1","Wert14",$gegnerfarbe)
	IniWrite("FLB.ini","Char_1","Wert15",$ex1)
	IniWrite("FLB.ini","Char_1","Wert16",$ex2)
	IniWrite("FLB.ini","Char_1","Wert17",$ey1)
	IniWrite("FLB.ini","Char_1","Wert18",$ey2)
	IniWrite("FLB.ini","Char_1","Wert19",$gx1)
	IniWrite("FLB.ini","Char_1","Wert20",$gy1)

EndFunc

Func PAUSE()													; F10 wurde gedrückt
While 1													; Schleife
Sleep(1)												; warten
WEnd													; Schleife ende
EndFunc													; Ende Funktion

Func ENDE()														; F11 wurde gedrückt
_Save ()
Exit													; Programm beenden
EndFunc													; Ende Funktion
Func movcamera()			; Kamera drehen
		$target = PixelGetColor( $gx1  , $gy1 )
	    if $target = $gegnerfarbe then
				    call ("str")
		sleep(100)
		Else
     MouseMove(650,120,1)	; Maus auf diese Position
	 sleep(100)		 		;040
     MouseDown("right")		; Rechte Maustaste gedrückt halten
	 sleep(100)				;
     MouseMove(651,120)		; Maus bewegen
	 sleep(100)				;
     MouseUp("right")		; Rechte Maustaste loslassen
     Sleep(100)				; Warten
	 endif
 EndFunc   					; Ende der Funktion


 Func ZielSuchen()										; Ziel suchen
	While 1
		$target = PixelGetColor( $gx1  , $gy1 )
	    if $target = $gegnerfarbe then
				    call ("str")
		sleep(100)
		Else
	$poslila = PixelSearch($ex1, $ey1, $ex2, $ey2, $erzfarbe,10)
	$errlila = @error
	If $errlila = 0 Then
		MouseMove ($poslila[0],$poslila[1],1)
		sleep(100)
		MouseClick("left")
		MouseClick("left")
		MouseClick("left")
		sleep(100)
	EndIf
	EndIf
	sleep (200)
	call ("movcamera")
		WEnd
EndFunc   												; Ende der Funkt

Func str()
		$STR = PixelSearch($x, $y, $x2, $y2,$c,2)
	    If IsArray($STR) = True Then
		$pos=MouseGetPos()
		MouseClick("left",$STR [0], $STR [1], 1,0)
		MouseMove($pos[0],$pos[1],0)
		sleep(50)
		endif
	Call("ZeilSuchen")
EndFunc

Func deaggro()
Send("{Enter}")
sleep(100)
Send("&refresh")
Sleep(100)
Send("{Enter}")
EndFunc

Func swap()
Send("3")
sleep(300)
EndFunc