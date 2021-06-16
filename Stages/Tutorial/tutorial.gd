extends Node2D




func _on_TextBox_cutscene_finished():
	var dababyScene = load("res://Characters/Dababy/dababyplayer.tscn")
	var dababyInstance = dababyScene.instance()
	var tree = get_tree().current_scene
	tree.add_child_below_node($Area2D, dababyInstance)
	dababyInstance.global_position = $Position2D.position


func _on_Area2D_area_entered(_area):
	Ssvariables.unlockDict["Stage 1"] = true
	$ColorRect2/AnimationPlayer.play("fadeout")


func _on_AnimationPlayer_animation_finished(_anim_name):
	get_tree().change_scene("res://Stages/Stage Select/stage_select.tscn")
