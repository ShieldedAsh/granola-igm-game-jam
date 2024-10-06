extends Node2D

signal playerVictory
signal playerLoss

func _ready():
	$AudioStreamPlayer2D.play()

func _on_player_loss():
	playerLoss.emit()

func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		playerVictory.emit()
