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
		newScene.backToTitle.connect(_on_pause_menu_load_main_menu)
	elif newScene.scene_file_path == "res://house.tscn":
		newScene.playerVictory.connect(_on_player_victory)
		newScene.playerLoss.connect(_on_player_loss)
	elif newScene.scene_file_path == "res://scenes/defeat.tscn":
		newScene.restart.connect(_on_intro_load_next)
		newScene.quit.connect(_on_pause_menu_load_main_menu)

func _on_main_menu_play():
	loadScene(preload("res://scenes/intro.tscn"))

func _on_pause_menu_load_main_menu():
	loadScene(preload("res://scripts/main_menu.tscn"))
	
func _on_intro_load_next():
	loadScene(preload("res://house.tscn"))
	
func _on_player_victory():
	loadScene(preload("res://scenes/victory_screen.tscn"))

func _on_player_loss():
	loadScene(preload("res://scenes/defeat.tscn"))
	
func _on_victory_quit():
	loadScene(preload("res://scripts/main_menu.tscn"))
