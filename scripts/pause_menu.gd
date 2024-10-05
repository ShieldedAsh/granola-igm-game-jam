extends Control

signal loadMainMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		match visible:
			true:
				visible = false
				get_tree().paused = false
			false:
				visible = true
				get_tree().paused = true


func _on_button_pressed(): #resume
	get_tree().paused = false
	visible = false

func _on_button_2_pressed(): #quit
	loadMainMenu.emit()
	visible = false
	get_tree().paused = false
