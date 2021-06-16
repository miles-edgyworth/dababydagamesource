extends KinematicBody2D

var state = MOVE
enum {IDLE, MOVE}
export var movespeed = 300

var motion = Vector2.ZERO

func _physics_process(delta):
	
	move_and_slide(motion)
	
	match state:
		
		IDLE:
			$AnimatedSprite.play("Idle")
			
			if Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down"):
				state = MOVE
		
		MOVE:
			
			var inputx = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
			var inputy = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
			
			if inputx != 0:
				motion.x = inputx
				motion.x = motion.x * movespeed
			else:
				motion.x = 0
			
			if inputy != 0:
				motion.y = inputy
				motion.y = motion.y * movespeed
				
				if inputy > 0:
					$AnimatedSprite.play("Up")
				elif inputy < 0:
					$AnimatedSprite.play("Down")
				
			else:
				motion.y = 0
				$AnimatedSprite.play("Idle")
			
			
			if Input.is_action_just_pressed("shoot"):
				var bulletScene = load("res://Stages/Stage 2/planebullet.tscn")
				var bulletInstance = bulletScene.instance()
				var tree = get_tree().current_scene
				tree.add_child(bulletInstance)
				bulletInstance.global_position = global_position + Vector2(20, 0)

