
extends Control

var drag_sprite
var drag_control

func _ready():
	pass

func get_drag_data(pos):
	print("get_drag_data in item_control")
	drag_sprite = Sprite.new()
	drag_sprite.set_opacity(0.5)
	drag_sprite.set_scale(Vector2(10, 10))
	
	drag_control = Control.new()
	drag_control.add_child(drag_sprite)
	drag_sprite.set_texture(get_node("item/item_sprite").get_texture())
	set_drag_preview(drag_control)
	
	return get_node("item")
	
func _on_item_moved(item):
	print("_on_item_moved", item, get_node("item"))
	# this item is moved now, blank it out
	if item == get_node("item"):
		print("found me")
		call_deferred("_clear_item")
		
func _clear_item():
	get_node("item").set_item(null)
