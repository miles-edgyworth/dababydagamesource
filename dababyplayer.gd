extends KinematicBody2D

const MOVESPEED = 100
const CONVERTIBLEMOVESPEED = 200
const GRAVITY = 400
const JUMPFORCE = 200
const UP = Vector2(0, -1)
const AIRRESISTANCE = .02
const BULLETSPEED = 5000

var playerHealth = 3

var inputx = 0

var state = IDLE

onready var gravitymotion = Vector2.ZERO
onready var motion = Vector2.ZERO

enum {IDLE, MOVE, SHOOT, TRANSFORMING, CONVERTIBLEIDLE, CONVERTIBLEMOVE, RTRANSFORMING, JUMP, FALL}

func _ready():
	$ProgressBar.visible = false

func _physics_process(delta):
	
	gravitymotion.y += GRAVITY * delta
	motion = move_and_slide(motion)
	gravitymotion = move_and_slide(gravitymotion, UP)
	
	match state:
		
		IDLE: #Can this be optimised?
			$dababyanimation.play("Idle")
			if Input.is_action_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
				state = MOVE
			elif Input.is_action_just_pressed("shoot"):
				state = SHOOT
			elif Input.is_action_just_pressed("transform"):
				state = TRANSFORMING
			elif Input.is_action_just_pressed("jump"):
				state = JUMP
			elif Input.is_action_just_pressed("transform"):
				state = TRANSFORMING
			
			
		
		MOVE:
			inputx = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
			if inputx != 0:
				motion.x = inputx * MOVESPEED
				if motion.x > 0:
					$dababyanimation.play("Run")
				else:
					$dababyanimation.play("RunLeft")
			else:
				motion = Vector2.ZERO
				state = IDLE
				
			if is_on_floor():
				motion.y = 0
			
			
			
			if Input.is_action_just_pressed("shoot"):
				state = SHOOT
			elif Input.is_action_just_pressed("jump"):
				state = JUMP
			elif Input.is_action_just_pressed("transform"):
				state = TRANSFORMING
		
		SHOOT:
			$dababyanimation.play("Shoot")
			motion = Vector2.ZERO
		
		TRANSFORMING:
			$dababyanimation.play("Transform")
		
		CONVERTIBLEIDLE:
			$dababyanimation.play("ConvertibleIdle")
			if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
				state = CONVERTIBLEMOVE
			elif Input. is_action_just_pressed("transform"):
				state = RTRANSFORMING
		
		CONVERTIBLEMOVE:
			inputx = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
			if inputx != 0:
				motion.x = inputx * CONVERTIBLEMOVESPEED
				if motion.x > 0:
					$dababyanimation.play("ConvertibleMoveRight")
				else:
					$dababyanimation.play("ConvertibleMoveLeft")
			else:
				motion = Vector2.ZERO
				state = CONVERTIBLEIDLE
			if Input.is_action_just_pressed("transform"):
				state = RTRANSFORMING
			
		RTRANSFORMING:
			$dababyanimation.play("RTransform")
		
		JUMP:
			motion.y = -JUMPFORCE
			$dababyanimation.play("Jump")
			inputx = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
			if inputx != 0:
				motion.x = inputx * MOVESPEED
			elif inputx == 0:
				motion.x = lerp(motion.x, 0, AIRRESISTANCE)
			if Input.is_action_just_released("jump"):
				state = FALL
			air_check()
		
		FALL:
			motion.y = -JUMPFORCE
			motion.y = lerp(motion.y, 0, 0.4)
			if is_on_floor():
				motion.y = 0
				state = MOVE
			inputx = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
			if inputx != 0:
				motion.x = inputx * MOVESPEED
			elif inputx == 0:
				motion.x = lerp(motion.x, 0, AIRRESISTANCE)
		

func shoot_state_finished():
	state = MOVE

func shoot_start():
	if state == SHOOT:
		spawn_bullet()

func air_check():
	if is_on_floor() == false:
		$Timer.start()

func _on_Timer_timeout():
	$Timer.stop()
	if is_on_floor() == true:
		state = MOVE
		motion.y = 0

func transform_finished():
	state = CONVERTIBLEIDLE
	motion.x = 0

func rtransform_finished():
	state = MOVE

func spawn_bullet():
	if $dababy.is_flipped_h():
		var bulletLeftLoad = load("res://Characters/Dababy/BulletLeft.tscn")
		var bulletLeftInstance = bulletLeftLoad.instance()
		var tree = get_tree().current_scene
		tree.add_child(bulletLeftInstance)
		bulletLeftInstance.global_position = global_position + Vector2(-7, 3)
	else:
		var bulletRightLoad = load("res://Characters/Dababy/Bullet.tscn")
		var bulletRightInstance = bulletRightLoad.instance()
		var tree = get_tree().current_scene
		tree.add_child(bulletRightInstance)
		bulletRightInstance.global_position = global_position + Vector2(7, 3)

func _on_DeathSensor_area_entered(_area):
	playerHealth -= 1
	$ProgressBar.visible = true
	$ProgressBar.value = playerHealth
	$ProgressBar/AnimationPlayer.play("fade")
	if playerHealth == -1:
		queue_free()
		get_tree().change_scene("res://Icons/loss.tscn")

func progress_disappear():
	$ProgressBar.visible = false

func _on_UltimateDeathSensor_area_entered(_area):
	queue_free()
	get_tree().change_scene("res://Icons/loss.tscn")
