extends Node2D

signal playerVictory
signal playerLoss

func _ready():
	$AudioStreamPlayer.play()

func _on_player_victory():
	playerVictory.emit()

func _on_player_loss():
	playerLoss.emit()
