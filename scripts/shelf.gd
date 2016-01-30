
extends Control

func _ready():

	get_node("item1_control/item").set_item("A")
	get_node("item2_control/item").set_item("B")
	get_node("item3_control/item").set_item("D")
	get_node("item4_control/item").set_item("AD")

