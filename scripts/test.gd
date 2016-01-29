
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"


func _ready():
	set_process(true)

func _process(delta):
	if Input.is_action_pressed("mouse_click"):
		# test if sprite clicked
		#print ("click")
		pass


