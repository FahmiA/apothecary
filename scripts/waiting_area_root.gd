
extends Node2D

var patronScene = null

func _ready():
	patronScene = preload("res://scenes/patron.scn")
	
	
func invite_patron():
	print("Inviting Patron...")
	
	var pads = get_tree().get_nodes_in_group("pad")
	var pad = pads[0]
	
	#var x = get_viewport_rect().size.width
	var x = pad.get_pos().x
	var y = 0
	
	var patronInstance = patronScene.instance()
	patronInstance.set_pos(Vector2(x, y))
	
	add_child(patronInstance)
