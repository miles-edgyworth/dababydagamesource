extends TextureRect

export var dialog = ["WELL, IF IT ISN 'T DABABY!", "...", "WHO ARE YOU?", "...............N-", "AYYY AYY AYY, CALM DOWN MAN!", "WHAT DO YOU EVEN WANT?", "ALL I WANT IS A GENTLEMANLY RAP BATTLE.", "IS THAT TOO MUCH TO ASK OF YOU, DABABY?", "BLAH.. BLAH.. BLAH...", "COOLSWAG."]
export var speaker = [0, 1, 2, 2, 1, 2, 2, 1, 1, 2, 2]
export var expression = ["Null", "Neutral", "Concerned", "Concerned", "Concerned", "Neutral", "Neutral", "Neutral", "Annoyed", "Aggressive", "Aggressive"]
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
			$DaadultPortrait/DaadultAnim.play(expression[0])
		else:
			$DababyPortrait/DababyAnim.play(expression[0])
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
