
extends Control

var tex_a
var tex_b
var tex_c
var tex_d

func _ready():
	# Initialization here
	tex_a = preload("res://textures/items/a.tex")
	tex_b = preload("res://textures/items/b.tex")
	tex_c = preload("res://textures/items/c.tex")
	tex_d = preload("res://textures/items/d.tex")


func set_item(item):
	if item == "A":
		get_node("item_sprite").set_texture(tex_a)
	elif item == "B":
		get_node("item_sprite").set_texture(tex_b)
	elif item == "C":
		get_node("item_sprite").set_texture(tex_c)
	elif item == "D":
		get_node("item_sprite").set_texture(tex_d)
		
		

