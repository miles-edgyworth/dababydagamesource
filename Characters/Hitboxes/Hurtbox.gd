extends Area2D

onready var colourRect = $"../ColorRect"
onready var rectAnimation = $"../ColorRect/AnimationPlayer"

func _on_CutsceneTrigger_area_entered(area):
	rectAnimation.play("Fade")
	print("lol")
