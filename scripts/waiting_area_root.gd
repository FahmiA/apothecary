
extends Node2D

var patron_scene = null

func _ready():
	patron_scene = preload("res://scenes/patron.scn")
	
	add_user_signal("item_moved")

func invite_patron(item_code):
	print("Inviting Patron...")
	
	if not has_free_pad():
		print("\tNo place for a new patron :(")
		return
	
	var pad = get_free_pad()
	
	var start_x = get_viewport_rect().size.width / 2
	var start_y = 0
	
	var target_x = pad.get_pos().x
	
	var patron_instance = patron_scene.instance()
	patron_instance.set_pos(Vector2(start_x, start_y))
	
	patron_instance.move_to(target_x)
	pad.set_occupied_node(patron_instance)
	
	add_child(patron_instance)
	
	patron_instance.set_need(item_code)
	
	patron_instance.connect("leave", self, "_on_patron_leave")
	patron_instance.connect("correct_item_recieved", self, "_on_patron_correct_item_recieved")
	patron_instance.connect("incorrect_item_recieved", self, "_on_patron_incorrect_item_recieved")
	
	print("\tPatron invited :)")

func _on_patron_leave(patron_node):
	var pad = get_occupied_path(patron_node)
	pad.clear()

func _on_patron_correct_item_recieved(patron_node, item):
	print("Correct item recieved")
	emit_signal("item_moved", item)
	
func _on_patron_incorrect_item_recieved(patron_node, item):
	print("incorrect item recieved")
	emit_signal("item_moved", item)

func has_free_pad():
	var pads = get_tree().get_nodes_in_group("pad")
	
	var result = false
	for pad in pads:
		result = result or not pad.is_occupied()
	
	return result
	
func get_free_pad():
	var pads = get_tree().get_nodes_in_group("pad")
	
	var first_free_pad = null
	for pad in pads:
		if not pad.is_occupied():
			first_free_pad = pad
			break
	
	return first_free_pad

func get_occupied_path(node):
	var pads = get_tree().get_nodes_in_group("pad")
	
	var matching_pad = null
	for pad in pads:
		if pad.get_occupied_node() == node:
			matching_pad = pad
			break
	
	return matching_pad