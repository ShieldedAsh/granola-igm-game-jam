extends Node2D

signal play

@onready var sound = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	sound.play()
	await get_tree().create_timer(.1).timeout
	play.emit()

func _on_button_pressed():
	sound.play()
	get_tree().quit()
