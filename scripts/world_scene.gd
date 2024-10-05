extends Node2D

func _ready():
	loadScene(preload("res://scripts/main_menu.tscn"))

func loadScene(scene:PackedScene):
	for i in get_children():
		if i.is_in_group("Level"):
			remove_child(i)
			i.queue_free()
	
	var newScene = scene.instantiate()
	add_child(newScene)
	
	if newScene.scene_file_path =="res://scripts/main_menu.tscn":
		newScene.play.connect(_on_main_menu_play)
	elif newScene.scene_file_path == "res://scenes/intro.tscn":
		newScene.loadNext.connect(_on_intro_load_next)
	elif newScene.scene_file_path == "res://scenes/victory_screen.tscn":
		newScene.backToTitle.connect()

func _on_main_menu_play():
	loadScene(preload("res://scenes/intro.tscn"))

func _on_pause_menu_load_main_menu():
	loadScene(preload("res://scripts/main_menu.tscn"))
	
func _on_intro_load_next():
	loadScene(preload("res://scenes/main.tscn"))
	
func _on_victory_quit():
	loadScene(preload("res://scripts/main_menu.tscn"))
