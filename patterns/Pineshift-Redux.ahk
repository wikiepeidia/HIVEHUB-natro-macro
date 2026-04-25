;@NoInterrupt
CameraRot(Dir, Num) {
	Static rot := false
	Static LRNum := 0
	Static LRDir := "Right"
	Init := OnExit((*) => rot && send("{" Rot%LRDir% " " Abs(LRNum) "}"), -1) 
	send "{" Rot%Dir% " " Num "}"
	rot := (dir = "Up" || dir = "Down" || dir = "Left" || dir = "Right")
	if (Dir="Left" || Dir="Right") {
		LRNum := (Dir="Left") ? LRNum+Num : LRNum-Num
		LRDir := (LRNum<0) ? "Right" : "Left"
	}
}
;function created by Kuruni and SP

Move(Dir, Dis, Dir2:="") {
	DirType := (Dir2!="")
	send "{" Dir " down}"
	if (DirType)
		send "{" Dir2 " down}"
	Walk(Dis)
	send "{" Dir " up}"
	if (DirType)
		send "{" Dir2 " up}"
}
;function created by Kuruni

loop reps {
	Move("d", 7, "s")
	Move("a", 1.75, "s")
	Move("w", 7, "a")
	Move("a", 1.75, "s")
	Move("s", 8, "d")
	Move("w", 1)
	Move("a", 1.75, "s")
	Move("w", 6, "a")
	Move("a", 1.75, "s")

	CameraRot("Left", 1)

	Move("s", 6)
	Move("d", 1.75)
	Move("w", 6)
	Move("d", 1.75)
	Move("s", 6)
	Move("d", 1.75)
	Move("w", 6)
	Move("d", 2)

	CameraRot("Left", 1)

	Move("a", 7, "s")
	Move("a", 1.75, "w")
	Move("w", 6, "d")
	Move("a", 1.75, "w")
	Move("a", 7, "s")
	Move("a", 1.75, "w")
	Move("w", 6, "d")
	Move("a", 2, "w")

	CameraRot("Right", 1)
	Sleep 50
	CameraRot("Right", 1)

	Move("s", 7, "d")
	Move("w", 1.75, "d")
	Move("a", 6, "w")
	Move("w", 1.75, "d")
	Move("s", 7, "d")
	Move("w", 1.75, "d")
	Move("a", 6, "w")
	Move("w", 2, "d")

	CameraRot("Left", 1)

	Move("s", 6)
	Move("a", 1.75)
	Move("w", 6)
	Move("a", 1.75)
	Move("s", 6)
	Move("a", 1.75)
	Move("w", 6)
	Move("a", 2)

	CameraRot("Left", 1)

	Move("a", 7, "s")
	Move("s", 1.75, "d")
	Move("w", 6, "d")
	Move("s", 1.75, "d")
	Move("a", 7, "s")
	Move("s", 1.75, "d")
	Move("w", 6, "d")
	Move("s", 2, "d")

	CameraRot("Right", 1)
	Sleep 50
	CameraRot("Right", 1)
}