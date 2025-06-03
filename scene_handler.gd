extends Node

func _ready():
	var newgame = get_node("MainMenu/M/VB/NewGame")
	newgame.pressed.connect(on_new_game_pressed)
	var quitgame = get_node("MainMenu/M/VB/Quit")
	quitgame.pressed.connect(on_quit_pressed)
	
func on_new_game_pressed():
	get_node("MainMenu").queue_free()
	get_tree().change_scene_to_file("res://Scenes/MainScenes/GameScene.tscn")
	
func on_quit_pressed():
	get_tree().quit()
