extends Node2D




func _on_Hitbox3_area_entered(_area):
	$ColorRect2/Tween.interpolate_property($ColorRect2, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1), 0.3, Tween.TRANS_LINEAR, Tween. EASE_IN_OUT)
	$ColorRect2/Tween.start()
	print("entered")


func _on_Tween_tween_all_completed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Stages/Stage 2/stage_02.tscn")
