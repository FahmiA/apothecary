
extends Node2D

const SPEED = 200 # Pixels per second

var target_x = 0

func _ready():
	pass

func _process(delta):
	var pos = get_pos()
	
	if pos.x < target_x:
		pos.x = target_x
		set_process(false)
	else:
		pos.x -= SPEED * delta
		
	set_pos(pos)
	
func move_to(x):
	target_x = x
	set_process(true)