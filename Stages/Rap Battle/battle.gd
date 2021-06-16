extends Node2D



func _on_TextureRect_cutscene_finished():
	var controllerScene = load("res://Stages/Rap Battle/Arrows/Controller.tscn")
	var controllerInstance = controllerScene.instance()
	var tree = get_tree().current_scene
	tree.add_child(controllerInstance)
