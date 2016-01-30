
extends Control

func _draw():
	var r = Rect2(Vector2(),get_size())
	draw_rect(r, Color(1,0,0,0.5) )

func _ready():
	pass

func get_drag_data(pos):
	print("get_drag_data in item_control1")
	return get_node("item").get_item()