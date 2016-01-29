
extends Node2D

var occupied = false

func _ready():
	# Initialization here
	pass

func is_occupied():
	return occupied

func set_occupied(occupied):
	self.occupied = occupied