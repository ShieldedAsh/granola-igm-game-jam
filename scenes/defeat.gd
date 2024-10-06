extends Node2D

signal restart
signal quit

func _on_restart_pressed():
	restart.emit()

func _on_quit_pressed():
	quit.emit()
