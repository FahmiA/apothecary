
extends Node2D

var occupied_node = null

func _ready():
	pass

func is_occupied():
	return occupied_node != null
	
func get_occupied_node():
	return occupied_node

func set_occupied_node(node):
	occupied_node = node
	
func clear():
	occupied_node = null