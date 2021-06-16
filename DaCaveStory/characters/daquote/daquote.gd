extends KinematicBody2D

var movement = Vector2.ZERO
var gravitymovement = Vector2.ZERO
var state = NULL
enum {NULL, IDLE, MOVE, JUMP}

export var canMove = true
export var jumping = false
export var lookingUp = false
export var friction = 0.4
export var air_resistance = 0.2
export var max_speed = 180
export var jumpforce = 200
export var gravity = 300
export var acceleration = 30
export var air_acceleration = 50
export var max_air_speed = 200
export var inspecting = false

signal inspected

func _ready():
	if canMove == true:
		state = IDLE
	else:
		state = NULL


func _physics_process(delta):
	
	gravitymovement.y += gravity * delta
	movement = move_and_slide(movement)
	gravitymovement  = move_and_slide(gravitymovement, Vector2.UP)
	
	
	
	match state:
		
		NULL:
			movement = Vector2.ZERO
		
		IDLE:
			movement.x = lerp(movement.x, 0, friction)
			if lookingUp == true:
				$dababy/dababyanim.play("lookup")
		
		MOVE:
			var inputx = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
			
			
			if inputx != 0:
				movement.x += inputx * acceleration
				movement.x = clamp(movement.x, -max_speed, max_speed)
				if movement.x > 0 and Input.is_action_pressed("ui_up") == false:
					$dababy/dababyanim.play("walk")
				elif movement.x < 0 and Input.is_action_pressed("ui_up") == false:
					$dababy/dababyanim.play("walkleft")
				elif movement.x > 0 and Input.is_action_pressed("ui_up") == true:
					$dababy/dababyanim.play("uplookwalk")
				elif movement.x < 0 and Input.is_action_pressed("ui_up") == true:
					$dababy/dababyanim.play("uplookwalkleft")
			else:
				state = IDLE
				$dababy/dababyanim.play("idle")
			
			
		JUMP:
			movement.y = -jumpforce
			air_check()
			
			var inputx = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
			
			if inputx != 0:
				movement.x += inputx * air_acceleration
				movement.x = clamp(movement.x, -max_air_speed, max_air_speed)
			
			if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
				movement.x = lerp(movement.x, 0, air_resistance)


func air_check():
	if is_on_floor() == false:
		$jumptimer.start()


func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_left"):
		if state == IDLE and jumping == false and canMove == true:
			state = MOVE
			inspecting = false
	
	if Input.is_action_just_pressed("ui_up") and state == IDLE:
		$dababy/dababyanim.play("lookup")
		lookingUp = true
		inspecting = false
	if Input.is_action_pressed("ui_up") and state == MOVE:
		lookingUp = true
		inspecting = false
	if Input.is_action_just_released("ui_up") and state == IDLE:
		$dababy/dababyanim.play("idle")
		lookingUp = false
		inspecting = false
	if Input.is_action_just_released("ui_up"):
		lookingUp = false
		inspecting = false
	
	if Input.is_action_just_pressed("jump") and canMove == true:
		$dababy/dababyanim.play("jump")
		jumping = true
		state = JUMP
		inspecting = false
	
	
	if Input.is_action_just_pressed("ui_down") and jumping == false:
		$dababy/dababyanim.play("inspect")
		inspecting = true
		emit_signal("inspected")


func _on_jumptimer_timeout():
	$jumptimer.stop()
	if is_on_floor():
		state = MOVE
		jumping = false
		movement.y = 0
