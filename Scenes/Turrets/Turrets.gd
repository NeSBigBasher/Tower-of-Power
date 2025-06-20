extends Node2D

var type 
var enemy_array = []
var built = false
var enemy 

func _ready():
	if built:
		self.get_node("Range/CollisionShape2D").get_shape().radius = 0.5 * GameData.tower_data[type]["range"]

func _physics_process(_delta):
	if enemy_array.size() != 0 and built:
		select_enemy()
		turn()
	
func turn():
	get_node("Turret").look_at(enemy.position)
	
func select_enemy():
	var enemy_progress_array = []
	##for i in enemy_array:
		##enemy_progress_array.append(i.progress)
	var max_offset = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_offset)
	enemy = enemy_array[enemy_index]
	
##func fire():

func _on_range_body_entered(body: Node2D) -> void:
	print (body.get_parent())
	enemy_array.append(body.get_parent())
	

func _on_range_body_exited(body: Node2D) -> void:
	enemy_array.erase(body.get_parent())
