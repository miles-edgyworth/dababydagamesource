extends Node2D



func _on_Area2D_area_entered(_area):
	$Area2D/ColorRect/AnimationPlayer.play("Fade")


func _on_AnimationPlayer_animation_finished(_anim_name):
	get_tree().change_scene("res://Stages/Rap Battle/battle.tscn")
