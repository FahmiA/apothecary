
extends Control

var drag_sprite
var drag_control

func _draw():
	var r = Rect2(Vector2(),get_size())
	draw_rect(r, Color(1,0,0,0.5) )

func _ready():
	pass

func _enter_tree():
	drag_sprite = Sprite.new()
	drag_sprite.set_opacity(0.5)
	drag_control = Control.new()
	drag_control.add_child(drag_sprite)

func get_drag_data(pos):
	print("get_drag_data in item_control1")
	drag_sprite.set_texture(get_node("item/item_sprite").get_texture())
	set_drag_preview(drag_control)
	
	
	return get_node("item").get_item()