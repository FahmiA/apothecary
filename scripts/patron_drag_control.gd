
extends Control
	
func _ready():
	add_user_signal("item_recieved")

func can_drop_data(pos, data):
	return true

func drop_data(pos, item):
	var item_code = item.get_item()
	emit_signal("item_recieved", item_code)