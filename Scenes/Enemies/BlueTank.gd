extends CharacterBody2D

var speed = 150
var hp = 50
var path: PathFollow2D

func _ready():
	path = get_parent() as PathFollow2D
	if path:
		print("Enemy spawned with valid path.")
	else:
		print("Enemy has no path!")

func _process(delta):
	path.progress += speed * delta
	if path.progress_ratio >= 1.0:
		on_destroy()

func on_hit(damage):
	hp -= damage
	if hp <= 0:
		on_destroy()
		
func on_destroy():
	self.queue_free()
