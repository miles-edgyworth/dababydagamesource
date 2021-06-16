extends Node2D


func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		var controllerScene = load("res://Stages/Rap Battle/Arrows/Controller.tscn")
		var controllerInstance = controllerScene.instance()
		var tree = get_tree().current_scene
		tree.add_child(controllerInstance)
