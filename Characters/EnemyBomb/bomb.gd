extends KinematicBody2D

var movespeed = 8
const GRAVITY = 4
const FRICTION = .2
var motion = Vector2.ZERO

func _physics_process(_delta):
	$AnimationPlayer.play("Thrown")
	
	motion.x = motion.x -movespeed
	motion.y += GRAVITY * FRICTION
	
	motion = move_and_slide(motion)



func _on_Hitbox_area_entered(_area):
	var explosionScene = load("res://Effects/explosion.tscn")
	var explosionInstance = explosionScene.instance()
	var tree = get_tree().current_scene
	tree.add_child(explosionInstance)
	explosionInstance.global_position = global_position
	queue_free()


func _on_Timer_timeout():
	var explosionScene = load("res://Effects/explosion.tscn")
	var explosionInstance = explosionScene.instance()
	var tree = get_tree().current_scene
	tree.add_child(explosionInstance)
	explosionInstance.global_position = global_position
	queue_free()
