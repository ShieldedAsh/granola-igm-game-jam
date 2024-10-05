extends Node2D


func loadScene(scene:PackedScene):
	for i in get_children():
		if i.is_in_group("Level"):
			remove_child(i)
			i.queue_free()
	
	var newScene = scene.instantiate()
	add_child(newScene)
	
	if newScene.scene_file_path == "res://main_menu.tscn":
		newScene.play.connect(_on_main_menu_play)
	

func _on_main_menu_play():
	loadScene(preload("res://scenes/main.tscn"))

func _on_pause_menu_load_main_menu():
	loadScene(preload("res://main_menu.tscn"))
