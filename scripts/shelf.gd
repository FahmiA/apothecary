
extends Control

func _ready():

	get_node("item1_control/item").set_item("AB")
	get_node("item2_control/item").set_item("BC")
	get_node("item3_control/item").set_item("D")
	get_node("item4_control/item").set_item("AD")

