extends KinematicBody2D

class_name basicEnemy

var state = IDLE
var direction = Vector2.ZERO
const MOVESPEED = 20
const GRAVITY = 200
enum {IDLE, WANDER, CHOOSE_DIRECTION, SHOOT}


func _physics_process(delta):
	
	move_and_slide(Vector2.DOWN * GRAVITY)
	
	match state:
		
		IDLE:
			$AnimationPlayer.play("Idle")
		
		CHOOSE_DIRECTION:
			direction = choose([Vector2.RIGHT, Vector2.LEFT])
			state = WANDER
		
		WANDER:
			move(delta)
			if direction.x > 0:
				$AnimationPlayer.play("WalkRight")
			else:
				$AnimationPlayer.play("WalkLeft")
		
		SHOOT:
			$AnimationPlayer.play("Shoot")
			

func move(delta):
	position += direction * MOVESPEED * delta

func shoot_finished():
	state = IDLE

func shoot():
	if state == SHOOT:
		if $Sprite.is_flipped_h():
			var bulletRightLoad = load("res://Characters/EnemyBasic/BulletRight.tscn")
			var bulletRightInstance = bulletRightLoad.instance()
			var tree = get_tree().current_scene
			tree.add_child(bulletRightInstance)
			bulletRightInstance.global_position = global_position + Vector2(7, 3)
		else:
			var bulletLeftLoad = load("res://Characters/EnemyBasic/BulletLeft.tscn")
			var bulletLeftInstance = bulletLeftLoad.instance()
			var tree = get_tree().current_scene
			tree.add_child(bulletLeftInstance)
			bulletLeftInstance.global_position = global_position + Vector2(-7, 3)

func _on_Hurtbox_area_entered(_area):
	queue_free()

func choose(array):
	array.shuffle()
	return array.front()

func _on_Timer_timeout():
	$Timer.wait_time = choose([1, 1.5, 2])
	state = choose([IDLE, CHOOSE_DIRECTION])

func _on_DetectionRight_area_entered(_area):
	state = SHOOT
	$Sprite.flip_h = false


func _on_DetectionLeft_area_entered(_area):
	state = SHOOT
	$Sprite.flip_h = true
