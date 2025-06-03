extends Node

var spawner_scene: PackedScene
var path_node: NodePath

func _ready():
	var spawner = spawner_scene.instantiate()
	add_child(spawner)

	spawner.enemy_scene = preload("res://Scenes/Enemies/BlueTank.tscn")  # Replace with your actual enemy path
	spawner.path_node = path_node  # Assign the Path2D node
