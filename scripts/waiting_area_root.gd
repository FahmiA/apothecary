
extends Node2D

var patronScene = null

func _ready():
	patronScene = preload("res://scenes/patron.scn")
	
	
func invite_patron():
	print("Inviting Patron...")
	
	if not has_free_pad():
		print("\tNo place for a new patron :(")
		return
	
	var pad = get_free_pad()
	
	var startX = get_viewport_rect().size.width / 2
	var startY = 0
	
	var targetX = pad.get_pos().x
	
	var patronInstance = patronScene.instance()
	patronInstance.set_pos(Vector2(startX, startY))
	
	patronInstance.move_to(targetX)
	pad.set_occupied(true)
	
	add_child(patronInstance)
	
	print("\tPatron invited :)")

func has_free_pad():
	var pads = get_tree().get_nodes_in_group("pad")
	
	var result = false
	for pad in pads:
		result = result or not pad.is_occupied()
	
	return result
	
func get_free_pad():
	var pads = get_tree().get_nodes_in_group("pad")
	
	var firstFreePad = null
	for pad in pads:
		if not pad.is_occupied():
			firstFreePad = pad
			break
	
	return firstFreePad