
extends Node2D

const SPEED = 200 # Pixels per second
const TARGET_DELTA_X = 10

var target_x = 0
var remove_after_move = false

var need = null

func _ready():
	add_user_signal("patience_expired")
	add_user_signal("correct_item_recieved")
	add_user_signal("incorrect_item_recieved")
	
	get_node("patience_timer").connect("timeout", self, "_on_patience_expired")
	get_node("drag_control").connect("item_recieved", self, "_on_item_recieved")
	
	set_need("ABC")
	
func set_need(need):
	self.need = need
	get_node("thought_bubble/item").set_item(need)

func _process(delta):
		
	var pos = get_pos()
	
	if abs(pos.x - target_x) <= TARGET_DELTA_X:
		# Destination reached
		
		if remove_after_move:
			self.queue_free()
		else:
			pos.x = target_x
			get_node("patron/AnimationPlayer").play("idle")
			get_node("thought_bubble/AnimationPlayer").stop()
			
			_start_patience_timer()
		
		set_process(false)
	else:
		# Keep moving to destination
		var delta_x = SPEED * delta
		
		if target_x < pos.x:
			pos.x -= delta_x
		else:
			pos.x += delta_x
	
	set_pos(pos)

func _start_patience_timer():
	var duration = rand_range(1, 5)
	print("patience: ", duration)
	
	var timerNode = get_node("patience_timer")
	timerNode.set_wait_time(duration)
	#timerNode.start()
	
func move_to(x, remove=false):
	target_x = x
	remove_after_move = remove
	
	# Animate in the correct direction
	if target_x <= get_pos().x:
		get_node("patron/AnimationPlayer").play("walk_left")
	else:
		get_node("patron/AnimationPlayer").play("walk_right")
	
	get_node("thought_bubble/AnimationPlayer").play("walk")
	
	set_process(true)
	
func _on_patience_expired():
	emit_signal("patience_expired", self)
	
	_leave()
	
func _on_item_recieved(item_code):
	if item_code == need:
		emit_signal("correct_item_recieved", self)
		
		_leave()
	else:
		emit_signal("incorrect_item_recieved", self)
	
func _leave():
	var targetX = get_viewport_rect().size.width + 100;
	move_to(targetX, true)
