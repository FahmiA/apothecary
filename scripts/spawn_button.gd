
extends Button

func _ready():
   self.connect("pressed", self, "_on_button_pressed");

func _on_button_pressed():
	var waitingAreaScene = get_node("/root/Node2D/waiting_area")
	waitingAreaScene.invite_patron()