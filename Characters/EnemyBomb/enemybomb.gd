extends KinematicBody2D

class_name enemyBomb

var state = IDLE

var rightThrow = false

enum{IDLE, THROW}

func _physics_process(_delta):
	match state:
		
		IDLE:
			$AnimationPlayer.play("Idle")
		THROW:
			$AnimationPlayer.play("Throw")

func _on_Hurtbox_area_entered(_area):
	queue_free()

func _on_DetectionRight_area_entered(_area):
	state = THROW
	rightThrow = false
	$Sprite.flip_h = false

func _on_DetectionLeft_area_entered(_area):
	state = THROW
	rightThrow = true
	$Sprite.flip_h = true

func spawn_bomb():
	if rightThrow == false:
		var bombScene = load("res://Characters/EnemyBomb/bomb.tscn")
		var bombInstance = bombScene.instance()
		var tree = get_tree().current_scene
		tree.add_child(bombInstance)
		bombInstance.global_position = global_position
	elif rightThrow == true:
		var bombScene = load("res://Characters/EnemyBomb/bombright.tscn")
		var bombInstance = bombScene.instance()
		var tree = get_tree().current_scene
		tree.add_child(bombInstance)
		bombInstance.global_position = global_position

func throw_finished():
	state = IDLE
