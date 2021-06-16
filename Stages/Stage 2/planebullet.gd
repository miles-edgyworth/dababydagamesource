extends KinematicBody2D

export var spd = 8

func _physics_process(delta):
	move_and_collide(Vector2.RIGHT * spd)

func _on_Timer_timeout():
	$Sprite/AnimationPlayer.play("die")

func myballshurt():
	queue_free()
