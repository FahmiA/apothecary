
extends Node2D

var item_1
var item_2
var item_result

func _ready():
	pass

func set_items(item_1, item_2, item_result):
	self.item_1 = item_1
	self.item_2 = item_2
	self.item_result = item_result
	
	get_node("item_1").set_item(item_1)
	get_node("item_2").set_item(item_2)
	get_node("item_result").set_item(item_result)

func are_items_equal(item_1, item_2, item_result):
	var ingredients_match = (self.item_1 == item_1 and self.item_2 == item_2) or (self.item_1 == item_2 and self.item_2 == item_1)
	var results_match = self.item_result == item_result
	
	return ingredients_match and results_match 