extends KinematicBody2D

var movement = Vector2.ZERO
const SPEED = 8000

func _physics_process(delta):
	movement.x = -SPEED * delta
	movement = move_and_slide(movement)

func _on_Timer_timeout():
	queue_free()
