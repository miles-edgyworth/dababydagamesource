extends KinematicBody2D

export var speed = 18000

func _physics_process(delta):
	move_and_slide(Vector2.UP * speed * delta)
	
	
	
