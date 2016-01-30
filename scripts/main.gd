
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():

	get_node("table").connect("on_item_moved", get_node("shelf/item1_control"), "_on_item_moved")
	get_node("table").connect("on_item_moved", get_node("shelf/item2_control"), "_on_item_moved")
	get_node("table").connect("on_item_moved", get_node("shelf/item3_control"), "_on_item_moved")
	get_node("table").connect("on_item_moved", get_node("shelf/item4_control"), "_on_item_moved")
	 


