extends Node2D

signal playerVictory
signal playerLoss

func _ready():
	$AudioStreamPlayer2D.play()

func _on_player_victory():
	playerVictory.emit()

func _on_player_loss():
	playerLoss.emit()
