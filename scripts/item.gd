
extends Control

var _item

func _ready():
	# Initialization here
	set_item(null)

func get_item():
	return _item

func set_item(item):
	_item = item
	if item:
		load_texture(item)
	else:
		get_node("item_sprite").set_texture(null)
	
func load_texture(item):
	get_node("item_sprite").set_texture(load("res://textures/items/%s.tex" % item))
