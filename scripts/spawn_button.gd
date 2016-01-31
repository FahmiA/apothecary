
extends Button

func _ready():
   self.connect("pressed", self, "_on_button_pressed");

func _on_button_pressed():
	var waitingAreaScene = get_node("/root/Control/waiting_area")
	var item_code = "A"
	#waitingAreaScene.invite_patron(item_code)
	get_tree().change_scene("res://scenes/title.scn")