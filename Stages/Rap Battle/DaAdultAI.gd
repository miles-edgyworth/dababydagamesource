extends Node2D

func _on_Timer_timeout():
	$Timer.wait_time = 0.4
	$Sprite/AnimationPlayer.play("Idle")

func _on_RightHit_body_entered(_body):
	$Sprite/AnimationPlayer.play("Right")
	$Timer.start()
	$"../Ui/Camera2D/EnemyCharting/TileMap".set_cell($"../Ui/Camera2D/EnemyCharting/TileMap".get_used_cells()[0][0], $"../Ui/Camera2D/EnemyCharting/TileMap".get_used_cells()[0][1], -1)

func _on_UpHit_body_entered(_body):
	$Sprite/AnimationPlayer.play("Up")
	$Timer.start()
	$"../Ui/Camera2D/EnemyCharting/TileMap".set_cell($"../Ui/Camera2D/EnemyCharting/TileMap".get_used_cells()[0][0], $"../Ui/Camera2D/EnemyCharting/TileMap".get_used_cells()[0][1], -1)

func _on_LeftHit_body_entered(_body):
	$Sprite/AnimationPlayer.play("Left")
	$Timer.start()
	$"../Ui/Camera2D/EnemyCharting/TileMap".set_cell($"../Ui/Camera2D/EnemyCharting/TileMap".get_used_cells()[0][0], $"../Ui/Camera2D/EnemyCharting/TileMap".get_used_cells()[0][1], -1)

func _on_DownHit_body_entered(_body):
	$Sprite/AnimationPlayer.play("Down")
	$Timer.start()
	$"../Ui/Camera2D/EnemyCharting/TileMap".set_cell($"../Ui/Camera2D/EnemyCharting/TileMap".get_used_cells()[0][0], $"../Ui/Camera2D/EnemyCharting/TileMap".get_used_cells()[0][1], -1)
