
extends Control

var contents = null


func _ready():
	# Initialization here
	pass

func _draw():
	var r = Rect2(Vector2(),get_size())
	draw_rect(r, Color(1,0,0,0.5) )

func can_drop_data(pos, data):
	print("can_drop_data in table")
	return true

func drop_data(pos, data):
	print("drop_data in table", data)
	#data == "A", "B", "C" etc.
	
	if not contents:
		contents = data
	else:
		# something already there, mix it
		contents = mix([data, contents])
		
	var tex = load("res://textures/items/%s.tex" % contents.to_lower())
	get_node("item").set_item(contents)


func mix(stuff):
	print("mix", stuff)
	stuff.sort()
	print("mix", stuff)
	if(stuff[0] == stuff[1]):
		return "X"
		
	if(stuff == ["A","B"]):
		return "C"
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
		
	return "X"		
	
	