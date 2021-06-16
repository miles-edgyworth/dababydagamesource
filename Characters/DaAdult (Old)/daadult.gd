extends KinematicBody2D

var state = IDLE
enum {IDLE, PRIMING, SHOOT}
var health = 3

func _physics_process(delta):
	match state:
		
		IDLE:
			$AnimationPlayer.play("Idle")
		
		PRIMING:
			$AnimationPlayer.play("Priming")
			$StopShooting.start()
		
		SHOOT:
			$AnimationPlayer.play("Shoot")

func prime_finished():
	state = SHOOT
	$Timer.start()

func _on_Detection_area_entered(area):
	state = PRIMING

func _on_Timer_timeout():
	$Timer.start()
	var bulletScene = load("res://Characters/EnemyBasic/BulletLeft.tscn")
	var bulletInstance = bulletScene.instance()
	var tree = get_tree().current_scene
	tree.add_child(bulletInstance)
	bulletInstance.global_position = global_position + Vector2(-10, 1)

func _on_StopShooting_timeout():
	state = IDLE
	$Timer.stop()

func _on_Hurtbox_area_entered(area):
	health -= 1
	if health == 0:
		queue_free()
		get_tree().change_scene("res://Icons/winscreen.tscn")
