
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
	add_user_signal("leave")
	
	get_node("patience_timer").connect("timeout", self, "_on_patience_expired")
	get_node("impatience_level_1_timer").connect("timeout", self, "_on_impatience_level_1")
	get_node("impatience_level_2_timer").connect("timeout", self, "_on_impatience_level_2")
	get_node("impatience_level_3_timer").connect("timeout", self, "_on_impatience_level_3")
	
	get_node("drag_control").connect("item_recieved", self, "_on_item_recieved")
	
func set_need(item_code):
	self.need = item_code
	get_node("thought_bubble/scale/item").set_item(item_code)

func _process(delta):
		
	var pos = get_pos()
	
	if abs(pos.x - target_x) <= TARGET_DELTA_X:
		# Destination reached
		
		if remove_after_move:
			self.queue_free()
		else:
			pos.x = target_x
			get_node("patron/AnimationPlayer").play("idle")
			
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
	var duration = rand_range(20, 30)
	
	_start_timer(get_node("patience_timer"), duration)
	_start_timer(get_node("impatience_level_1_timer"), duration * 0.4)
	_start_timer(get_node("impatience_level_2_timer"), duration * 0.6)
	_start_timer(get_node("impatience_level_3_timer"), duration * 0.8)
	
func _start_timer(timer_node, duration):
	timer_node.set_wait_time(duration)
	timer_node.start()
	
func move_to(x, remove=false):
	target_x = x
	remove_after_move = remove
	
	# Animate in the correct direction
	if target_x <= get_pos().x:
		get_node("patron/AnimationPlayer").play("walk_left")
	else:
		get_node("patron/AnimationPlayer").play("walk_right")
	
	set_process(true)
	
func _on_patience_expired():
	emit_signal("patience_expired", need)
	get_node("patron/sound").play("boo")
	_leave()

func _on_impatience_level_1():
	get_node("patron/AnimationPlayer").play("impatient_level_1")
	
func _on_impatience_level_2():
	get_node("patron/AnimationPlayer").play("impatient_level_2")
	
func _on_impatience_level_3():
	get_node("patron/AnimationPlayer").play("impatient_level_3")
	
func _on_item_recieved(item):
	if item.get_item() == need:
		emit_signal("correct_item_recieved", self, item)
		get_node("patron/sound").play("yay")
		_leave()
	else:
		emit_signal("incorrect_item_recieved", self, item)
		
		_lose_patience()
	
func _leave():
	emit_signal("leave", self)
	
	var targetX = get_viewport_rect().size.width + 100;
	move_to(targetX, true)
	
	get_node("thought_bubble").hide()
	
	get_node("patience_timer").stop()
	get_node("impatience_level_1_timer").stop()
	get_node("impatience_level_2_timer").stop()
	get_node("impatience_level_3_timer").stop()
	
	get_node("drag_control").queue_free()
	
func _lose_patience():
	# Bring the next active timer forward
	var timer_nodes = [
		get_node("impatience_level_1_timer"),
		get_node("impatience_level_2_timer"),
		get_node("impatience_level_3_timer"),
		get_node("patience_timer")
	]

	for timer_node in timer_nodes:
		if timer_node.get_time_left() > 0:
			timer_node.stop()
			timer_node.set_wait_time(0.5)
			timer_node.start()
			break