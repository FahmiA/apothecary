
extends Control

func _ready():
	set_process_input(true)

func _input_event(ev):
	if Input.is_action_pressed("mouse_click") or Input.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://scenes/main.scn")