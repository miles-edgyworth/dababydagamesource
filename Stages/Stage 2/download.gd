extends Sprite

var daHealth = 30

func _on_Hurtbox_area_entered(area):
	daHealth -= 1
	$AnimationPlayer.play("hurt")
	
	if daHealth == 0:
		queue_free()
		get_tree().change_scene("res://DaCaveStory/rooms/firstroom.tscn")
