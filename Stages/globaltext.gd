extends TextureRect

export var dialog = []
export var speaker = []
export var expression = []
var dialogIndex = 0
var isFinished = false
signal cutscene_finished

func _ready():
	play_text()

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		play_text()
	$Sprite.visible = isFinished
	$Sprite2.visible = isFinished
	if $RichTextLabel.percent_visible == 1:
		isFinished = true


func play_text():
	if dialogIndex < dialog.size():
		array_modify(speaker)
		array_modify(expression)
		if speaker.front() == 1:
			$Speaker1/Speaker1Anim.play(expression[0])
		else:
			$Speaker2/Speaker2Anim.play(expression[0])
		isFinished = false
		$RichTextLabel.bbcode_text = dialog[dialogIndex]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property($RichTextLabel, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
	else:
		queue_free()
		emit_signal("cutscene_finished")
	dialogIndex += 1

func array_modify(array):
	array.remove(0)
	return array.front()
