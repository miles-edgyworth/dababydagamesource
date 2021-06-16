extends Node2D

enum {NULL, SING}
var state = NULL
var score = 0

var lefthit = false
var uphit = false
var downhit = false
var righthit = false

var inleft = false
var inup = false
var indown = false
var inright = false

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_left") and state == NULL:
		$Dababy/AnimationPlayer.play("LeftMiss")
		$Ui/Camera2D/Arrows/Left.frame = 1
		$Timer.start()
		score -= 10
		$Ui/Camera2D/ScoreText/ScoreDisplay.bbcode_text = String(score)
		$Ui/Camera2D/ProgressBar.value -= 5
	
	elif Input.is_action_just_pressed("ui_down") and state == NULL:
		$Dababy/AnimationPlayer.play("DownMiss")
		$Ui/Camera2D/Arrows/Down.frame = 1
		$Timer.start()
		score -= 10
		$Ui/Camera2D/ScoreText/ScoreDisplay.bbcode_text = String(score)
		$Ui/Camera2D/ProgressBar.value -= 5
	
	elif Input.is_action_just_pressed("ui_up") and state == NULL:
		$Dababy/AnimationPlayer.play("UpMiss")
		$Ui/Camera2D/Arrows/Up.frame = 1
		$Timer.start()
		score -= 10
		$Ui/Camera2D/ScoreText/ScoreDisplay.bbcode_text = String(score)
		$Ui/Camera2D/ProgressBar.value -= 5
	
	elif Input.is_action_just_pressed("ui_right") and state == NULL:
		$Dababy/AnimationPlayer.play("RightMiss")
		$Ui/Camera2D/Arrows/Right.frame = 1
		$Timer.start()
		score -= 10
		$Ui/Camera2D/ScoreText/ScoreDisplay.bbcode_text = String(score)
		$Ui/Camera2D/ProgressBar.value -= 5
	
	match state:
			
			NULL:
				pass
			
			SING:
				if Input.is_action_just_pressed("ui_right") and inright == true:
					$Timer.start()
					$Ui/Camera2D/Arrows/Right.frame = 1
					$Dababy/AnimationPlayer.play("Right")
					score += 10
					state = NULL
					$Ui/Camera2D/ScoreText/ScoreDisplay.bbcode_text = String(score)
					$Ui/Camera2D/ProgressBar.value += 5
					righthit = true
					$Ui/Camera2D/PlayerCharting/TileMap.set_cell($Ui/Camera2D/PlayerCharting/TileMap.get_used_cells()[0][0], $Ui/Camera2D/PlayerCharting/TileMap.get_used_cells()[0][1], -1)
				
				if Input.is_action_just_pressed("ui_up") and inup == true:
					$Timer.start()
					$Ui/Camera2D/Arrows/Up.frame = 1
					$Dababy/AnimationPlayer.play("Up")
					score += 10
					state = NULL
					$Ui/Camera2D/ScoreText/ScoreDisplay.bbcode_text = String(score)
					$Ui/Camera2D/ProgressBar.value += 5
					uphit = true
					$Ui/Camera2D/PlayerCharting/TileMap.set_cell($Ui/Camera2D/PlayerCharting/TileMap.get_used_cells()[0][0], $Ui/Camera2D/PlayerCharting/TileMap.get_used_cells()[0][1], -1)
			
				if Input.is_action_just_pressed("ui_down") and indown == true:
					$Timer.start()
					$Ui/Camera2D/Arrows/Down.frame = 1
					$Dababy/AnimationPlayer.play("Down")
					score += 10
					state = NULL
					$Ui/Camera2D/ScoreText/ScoreDisplay.bbcode_text = String(score)
					$Ui/Camera2D/ProgressBar.value += 5
					downhit = true
					$Ui/Camera2D/PlayerCharting/TileMap.set_cell($Ui/Camera2D/PlayerCharting/TileMap.get_used_cells()[0][0], $Ui/Camera2D/PlayerCharting/TileMap.get_used_cells()[0][1], -1)
				
				if Input.is_action_just_pressed("ui_left") and inleft == true:
					$Timer.start()
					$Ui/Camera2D/Arrows/Left.frame = 1
					$Dababy/AnimationPlayer.play("Left")
					state = NULL
					score += 10
					$Ui/Camera2D/ScoreText/ScoreDisplay.bbcode_text = String(score)
					$Ui/Camera2D/ProgressBar.value += 5
					lefthit = true
					$Ui/Camera2D/PlayerCharting/TileMap.set_cell($Ui/Camera2D/PlayerCharting/TileMap.get_used_cells()[0][0], $Ui/Camera2D/PlayerCharting/TileMap.get_used_cells()[0][1], -1)
	
	
	if $Ui/Camera2D/ProgressBar.value == 0:
		get_tree().change_scene("res://Icons/rabbattledeath.tscn")

func _on_Timer_timeout():
	$Timer.wait_time = 0.05
	$Ui/Camera2D/Arrows/Left.frame = 0
	$Ui/Camera2D/Arrows/Down.frame = 0
	$Ui/Camera2D/Arrows/Up.frame = 0
	$Ui/Camera2D/Arrows/Right.frame = 0

func anim_finished():
	$Dababy/AnimationPlayer.play("Idle")


func _on_AudioStreamPlayer_finished():
	$fade/AnimationPlayer.play("fadeout")
	get_tree().change_scene("res://Stages/Stage Select/stage_select.tscn")
	Ssvariables.unlockDict["Stage 2"] = true


func _on_LeftHitbox_body_entered(_body):
	state = SING
	lefthit = false
	inleft = true

func _on_DownHitbox_body_entered(_body):
	state = SING
	downhit = false
	indown = true

func _on_UpHitbox_body_entered(_body):
	state = SING
	uphit = false
	inup = true

func _on_RightHitbox_body_entered(_body):
	state = SING
	righthit = false
	inright = true

func _on_LeftHitbox_body_exited(_body):
	inleft = false
	if lefthit == false:
		$Ui/Camera2D/ProgressBar.value -= 5
		score -= 10
		$Ui/Camera2D/ScoreText/ScoreDisplay.bbcode_text = String(score)
		state = NULL
		$Ui/Camera2D/PlayerCharting/TileMap.set_cell($Ui/Camera2D/PlayerCharting/TileMap.get_used_cells()[0][0], $Ui/Camera2D/PlayerCharting/TileMap.get_used_cells()[0][1], -1)

func _on_DownHitbox_body_exited(_body):
	indown = false
	if downhit == false:
		$Ui/Camera2D/ProgressBar.value -= 5
		score -= 10
		$Ui/Camera2D/ScoreText/ScoreDisplay.bbcode_text = String(score)
		state = NULL
		$Ui/Camera2D/PlayerCharting/TileMap.set_cell($Ui/Camera2D/PlayerCharting/TileMap.get_used_cells()[0][0], $Ui/Camera2D/PlayerCharting/TileMap.get_used_cells()[0][1], -1)

func _on_UpHitbox_body_exited(_body):
	inup = false
	if uphit == false:
		$Ui/Camera2D/ProgressBar.value -= 5
		score -= 10
		$Ui/Camera2D/ScoreText/ScoreDisplay.bbcode_text = String(score)
		state = NULL
		$Ui/Camera2D/PlayerCharting/TileMap.set_cell($Ui/Camera2D/PlayerCharting/TileMap.get_used_cells()[0][0], $Ui/Camera2D/PlayerCharting/TileMap.get_used_cells()[0][1], -1)

func _on_RightHitbox_body_exited(_body):
	inright = false
	if righthit == false:
		$Ui/Camera2D/ProgressBar.value -= 5
		score -= 10
		$Ui/Camera2D/ScoreText/ScoreDisplay.bbcode_text = String(score)
		state = NULL
		$Ui/Camera2D/PlayerCharting/TileMap.set_cell($Ui/Camera2D/PlayerCharting/TileMap.get_used_cells()[0][0], $Ui/Camera2D/PlayerCharting/TileMap.get_used_cells()[0][1], -1)
