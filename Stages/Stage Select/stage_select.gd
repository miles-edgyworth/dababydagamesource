extends Node2D

enum {TUTORIAL, STAGE1, STAGE2, STAGE3, STAGE4, STAGE5}
var state = TUTORIAL

var textArray = ["TUTORIAL", "DACITY", "DASKY", "DAVOID", "", ""]
var bossArray = ["DAGIRLFRIEND", "DAADULT", "DAMOTHER", "???", ""]

func _ready():
	if Ssvariables.unlockDict["Stage 1"] == true:
		$stage1lock.visible = false
	if Ssvariables.unlockDict["Stage 2"] == true:
		$stage2lock.visible = false
	if Ssvariables.unlockDict["Stage 3"] == true:
		$stage3lock.visible = false

func _physics_process(_delta):
	
	match state:
		
		TUTORIAL:
			$AnimatedSprite.position = $Icons/Tutorial.position
			$Icons/Tutorial/Icon.visible = true
			$Control/stage.text = textArray[0]
			$Control/stage/boss.text = bossArray[0]
			if Input.is_action_just_pressed("ui_right") and Ssvariables.unlockDict["Stage 1"] == true:
				$Icons/Tutorial/Icon.visible = false
				state = STAGE1
			elif Input.is_action_just_pressed("ui_accept"):
				$fade/AnimationPlayer.play("fadeout")
				get_tree().change_scene("res://Stages/Tutorial/tutorial.tscn")
		
		STAGE1:
			$AnimatedSprite.position = $Icons/Stage1.position
			$Icons/Stage1/Icon.visible = true
			$Control/stage.text = textArray[1]
			$Control/stage/boss.text = bossArray[1]
			if Input.is_action_just_pressed("ui_right") and Ssvariables.unlockDict["Stage 2"] == true:
				$Icons/Stage1/Icon.visible = false
				state = STAGE2
			elif Input.is_action_just_pressed("ui_left"):
				$Icons/Stage1/Icon.visible = false
				state = TUTORIAL
			elif Input.is_action_just_pressed("ui_accept"):
				$fade/AnimationPlayer.play("fadeout")
				get_tree().change_scene("res://Stages/Stage 1/stage_01.tscn")
		
		STAGE2:
			$AnimatedSprite.position = $Icons/Stage2.position
			$Icons/Stage2/Icon.visible = true
			$Control/stage.text = textArray[2]
			$Control/stage/boss.text = bossArray[2]
			if Input.is_action_just_pressed("ui_left"):
				state = STAGE1
				$Icons/Stage2/Icon.visible = false
			elif Input.is_action_just_pressed("ui_right") and Ssvariables.unlockDict["Stage 3"] == true:
				state = STAGE3
				$Icons/Stage2/Icon.visible = false
			elif Input.is_action_just_pressed("ui_accept"):
				get_tree().change_scene("res://Stages/Stage 2/stage_02_intro.tscn")
		
		STAGE3:
			$AnimatedSprite.position = $Icons/Stage3.position
			$Control/stage.text = textArray[3]
			$Control/stage/boss.text = bossArray[3]
			if Input.is_aciton_just_pressed("ui_left"):
				state = STAGE2
