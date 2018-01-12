extends Node

const UP = 90
const DOWN = 270
const LEFT = 180
const RIGHT = 0

export (PackedScene) var dispenser
var gamemode = 0
var screensize

func _ready():
	screensize = get_node("/root").get_viewport().get_visible_rect().size
	
	$Player/SpawnPosition.position = screensize / 2
	$Player.position = $Player/SpawnPosition.position
	
	var player_x = $Player.position.x
	var player_y = $Player.position.y
	
	# --- Setup dispensers ---
	# Up
	var dispenser1 = dispenser.instance()
	dispenser1.set_name('Dispenser1')
	add_child(dispenser1)
	dispenser1.setup(Vector2(player_x, player_y - player_x / 2), DOWN)
	dispenser1.get_node("/root/Game/Main/Dispenser1/Sprite").flip_v = false
	
	# Down
	var dispenser2 = dispenser.instance()
	dispenser2.set_name('Dispenser2')
	add_child(dispenser2)
	dispenser2.setup(Vector2(player_x, player_y + player_x / 2), UP)
	dispenser2.get_node("/root/Game/Main/Dispenser2/Sprite").flip_v = true
	
	# Left
	var dispenser3 = dispenser.instance()
	dispenser3.set_name('Dispenser3')
	add_child(dispenser3)
	dispenser3.setup(Vector2(player_x - player_x / 2, player_y), RIGHT)
	dispenser3.get_node("/root/Game/Main/Dispenser3/Sprite").flip_h = true
	
	# Right
	var dispenser4 = dispenser.instance()
	dispenser4.set_name('Dispenser4')
	add_child(dispenser4)
	dispenser4.setup(Vector2(player_x + player_x / 2, player_y), LEFT)
	dispenser4.get_node("/root/Game/Main/Dispenser4/Sprite").flip_h = false

func _process(delta):
	match [gamemode]:
		[0]: random()
		[1]: level1()
	
func random():
	if randi() % 100 == 0:
		var nodes_before_dispensers = 3
		var dispenser = get_child(randi() % 4 + nodes_before_dispensers)
		dispenser.shoot()

func level1():
	pass

func load_level(level_number):
	var level = File.new()
	level.open("res://levels/level" + str(level_number) + ".lvl", File.READ)
	var content = ""
	while not level.eof_reached():
		var line = level.get_line()
		if not line.begins_with("#"):
			content += line + "\n"
	level.close()
	return content
