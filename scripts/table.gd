
extends Control

var contents = null


func _ready():
	# Initialization here
	add_user_signal("on_item_moved")

func _draw():
	var r = Rect2(Vector2(),get_size())
	draw_rect(r, Color(1,0,0,0.5) )

func can_drop_data(pos, data):
	print("can_drop_data in table")
	return true

func drop_data(pos, data):
	print("drop_data in table", data, data.get_item())

	emit_signal("on_item_moved", data)

	if not contents:
		contents = data.get_item()
	else:
		# something already there, mix it
		contents = mix([data.get_item(), contents])
		emit_signal("items_mixed", data)

	print(contents)
	var tex = load("res://textures/items/%s.tex" % contents.to_lower())
	get_node("item").set_item(contents)


func mix(stuff):
	print("mix", stuff)
	stuff.sort()
	print("mix", stuff)
	if(stuff[0] == stuff[1]):
		return "X"
		
	if(stuff == ["A","B"]):
		return "AB"
	if(stuff == ["A","C"]):
		return "AC"
	if(stuff == ["A","D"]):
		return "AD"
	if(stuff == ["B","C"]):
		return "BC"
	if(stuff == ["B","D"]):
		return "BD"
	if(stuff == ["C","D"]):
		return "CD"

	if(stuff == ["AB","BC"]):
		return "ABC"
	if(stuff == ["AB","AC"]):
		return "ABC"
	if(stuff == ["AC","BC"]):
		return "ABC"
	if(stuff == ["AB","AD"]):
		return "ABD"
	if(stuff == ["AB","BD"]):
		return "ABD"
	if(stuff == ["AD","BD"]):
		return "ABD"
	if(stuff == ["AC","AD"]):
		return "ACD"
	if(stuff == ["AD","CD"]):
		return "ACD"
	if(stuff == ["AC","CD"]):
		return "ACD"
	if(stuff == ["BC","BD"]):
		return "BCD"
	if(stuff == ["BC","CD"]):
		return "BCD"
	if(stuff == ["BD","CD"]):
		return "BCD"

	if(stuff == ["ABC","D"]):
		return "ABCD"
	if(stuff == ["ABD","C"]):
		return "ABCD"
	if(stuff == ["ACD","B"]):
		return "ABCD"
	if(stuff == ["A","BCD"]):
		return "ABCD"
		
	return "X"
	
func get_drag_data(pos):
	return get_node("item")
	
func _on_item_moved():
	print("_on_item_moved", get_node("item"))
	# this item is moved now, blank it out
	
	contents = null
	call_deferred("_clear_item")
		
func _clear_item():
	get_node("item").set_item(null)