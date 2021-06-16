extends Node2D

var inspected = false
var inspectable = false


func _on_Area2D_area_entered(area):
	inspectable = true



func _physics_process(delta):
	if inspected == true:
		$trolled.visible = true


func _on_DaQuote_inspected():
	if inspectable == true:
		inspected = true
		$AudioStreamPlayer.play()
		$Timer.start()




func _on_Timer_timeout():
	get_tree().change_scene("res://DaCaveStory/rooms/credits.tscn")
