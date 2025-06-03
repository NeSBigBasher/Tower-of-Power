extends Node2D

var map_node 

var enemy_scene = load("res://Scenes/Enemies/BlueTank.tscn")
var spawn_interval: float = 2.0
var timer = 0.0
var build_mode= false
var build_valid = false 
var build_location
var build_tile
var build_type 

var current_wave = 0
var enemies_in_wave = 0

func _ready():
	map_node = get_node("Map1") 
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.pressed.connect(initiate_build_mode.bind(i.name))
	
func _process(delta):
	timer += delta
	if timer >= spawn_interval:
		timer = 0.0
		spawn_enemy()
	if build_mode:
		update_tower_preview()
	
func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		cancel_build_mode()
	if event.is_action_released("ui_accept") and build_mode == true:
		verify_and_build()
		cancel_build_mode()

##
## Wave Functions
##
##func start_next_wave():

		
##func retrieve_wave_data():

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	var path_node = get_node("Map1/Path") as Path2D
	var path_follow = PathFollow2D.new()
	path_follow.set_progress_ratio(0.0)
	path_node.add_child(path_follow)
	path_follow.progress_ratio = 0.0
	path_follow.add_child(enemy)
	print("Enemy spawned at: ", path_follow.global_position)
	##enemy.position = Vector2.ZERO
	##enemy.rotation = 0
##
## Building Functions
##

func initiate_build_mode(tower_type):
	if build_mode:
			cancel_build_mode()
	build_type = tower_type + "T1"
	build_mode = true 
	get_node("UI").set_tower_preview(build_type, get_global_mouse_position())

func update_tower_preview():
	var mouse_position = get_global_mouse_position()
	var current_tile = map_node.get_node("TowerExclusion").local_to_map(mouse_position)
	var tile_position = map_node.get_node("TowerExclusion").map_to_local(current_tile)
	var tile_id = map_node.get_node("TowerExclusion").get_cell_source_id(current_tile)
	if tile_id != -1:
		get_node("UI").update_tower_preview(tile_position, "ff0000b6") # Red = Invalid
		build_valid = false
	else:
		get_node("UI").update_tower_preview(tile_position, "00ff00c8") # Green = Valid
		build_valid = true 
		build_location = tile_position
		build_tile = current_tile

func cancel_build_mode():
	build_mode = false 
	build_valid = false 
	get_node("UI/TowerPreview").free()
	
func verify_and_build():
	if build_valid:
		var new_tower = load("res://Scenes/Turrets/" + build_type + ".tscn").instantiate()
		new_tower.position = build_location
		new_tower.built = true
		new_tower.type = build_type
		map_node.get_node("Turrets").add_child(new_tower, true)
		map_node.get_node("TowerExclusion").set_cell(build_tile, 2, Vector2(1, 0))
