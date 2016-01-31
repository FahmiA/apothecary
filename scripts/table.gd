
extends Control

var contents = null


func _ready():
	# Initialization here
	add_user_signal("on_item_moved")
	add_user_signal("items_mixed")

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
		
		get_node("item/magic/AnimationPlayer").play("poof")

	var tex = load("res://textures/items/%s.tex" % contents.to_lower())
	get_node("item").set_item(contents)


func mix(stuff):
	stuff.sort()
	
	if(stuff[0] == stuff[1]):
		return stuff[0]
	
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

	if(stuff == ["A","BC"]):
		return "ABC"
	if(stuff == ["A","BD"]):
		return "ABD"
	if(stuff == ["A","CD"]):
		return "ACD"
	if(stuff == ["AC","B"]):
		return "ABC"
	if(stuff == ["AD","B"]):
		return "ABD"
	if(stuff == ["B","CD"]):
		return "BCD"
	if(stuff == ["AB","C"]):
		return "ABC"
	if(stuff == ["AD","C"]):
		return "ACD"
	if(stuff == ["BD","C"]):
		return "BCD"
	if(stuff == ["AB","D"]):
		return "ABD"
	if(stuff == ["AC","D"]):
		return "ACD"
	if(stuff == ["BC","D"]):
		return "BCD"
	
			
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

	if(stuff == ["A","X"]):
		return "A"
	if(stuff == ["B","X"]):
		return "B"
	if(stuff == ["C","X"]):
		return "C"
	if(stuff == ["D","X"]):
		return "D"

	return "X"
	
func get_drag_data(pos):
	var drag_sprite = Sprite.new()
	drag_sprite.set_opacity(0.5)
	drag_sprite.set_scale(Vector2(10, 10))
	
	var drag_control = Control.new()
	drag_control.add_child(drag_sprite)
	drag_sprite.set_texture(get_node("item/item_sprite").get_texture())
	set_drag_preview(drag_control)
	
	return get_node("item")
	
func _on_item_moved(item):
	print("table  _on_item_moved", get_node("item"))
	
	if item == get_node("item"):
		# this item is moved now, blank it out
		contents = null
		call_deferred("_clear_item")
		
func _clear_item():
	get_node("item").set_item(null)