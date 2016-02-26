
extends Control

const ITEM_CHOICES_EASY =	["A", "B", "C", "D"]
const ITEM_CHOICES_MEDIUM =	["AB", "AC", "AD", "BC", "BD", "CD"]
const ITEM_CHOICES_HARD =	["ABC", "ACD", "ABD", "BCD"]
const ITEM_CHOICES_EXTREME =["ABCD"]

var item_choices = []
var game_ended = false

func _ready():
	# Bind drag events from table
	get_node("table").connect("on_item_moved", get_node("shelf/item1_control"), "_on_item_moved")
	get_node("table").connect("on_item_moved", get_node("shelf/item2_control"), "_on_item_moved")
	get_node("table").connect("on_item_moved", get_node("shelf/item3_control"), "_on_item_moved")
	get_node("table").connect("on_item_moved", get_node("shelf/item4_control"), "_on_item_moved")
	get_node("table").connect("items_mixed", self, "_on_items_mixed")
	
	# Bind drag events from waiting area
	get_node("waiting_area").connect("item_moved", get_node("table"), "_on_item_moved")
	get_node("waiting_area").connect("item_moved", get_node("shelf/item1_control"), "_on_item_moved")
	get_node("waiting_area").connect("item_moved", get_node("shelf/item2_control"), "_on_item_moved")
	get_node("waiting_area").connect("item_moved", get_node("shelf/item3_control"), "_on_item_moved")
	get_node("waiting_area").connect("item_moved", get_node("shelf/item4_control"), "_on_item_moved")
	
	# Bind event from jar shelf
	get_node("jar_shelf").connect("all_jars_broken", self, "_on_game_end")
	
	get_node("waiting_area").connect("correct_item_recieved", get_node("jar_shelf"), "_on_correct_item_recieved")
	get_node("waiting_area").connect("patron_patience_expired", get_node("jar_shelf"), "_on_patron_patience_expired")

	# Bind timer difficulty events
	get_node("timer_easy").connect("timeout", self, "_on_timer_easy")
	get_node("timer_medium").connect("timeout", self, "_on_timer_medium")
	get_node("timer_hard").connect("timeout", self, "_on_timer_hard")
	get_node("timer_extreme").connect("timeout", self, "_on_timer_extreme")
	
	# Bind timer patron spawn events
	get_node("patron_timer").connect("timeout", self, "_on_new_patron")
	
func _on_items_mixed(item_1, item_2, item_result):
	get_node("background/arms/AnimationPlayer").play("mix")
	get_node("mix_memory").add_memory(item_1, item_2, item_result)
	
func _on_new_patron():
	if not item_choices.empty():
		var random_index = rand_range(0, item_choices.size())
		var item_code = item_choices[random_index]
		get_node("waiting_area").invite_patron(item_code)

func _on_timer_easy():
	print("Here we go!")
	_append_choices(ITEM_CHOICES_EASY)

func _on_timer_medium():
	print("Difficulty upgrade: Medium")
	_append_choices(ITEM_CHOICES_MEDIUM)

func _on_timer_hard():
	print("Difficulty upgrade: Hard")
	_append_choices(ITEM_CHOICES_HARD)

func _on_timer_extreme():
	print("Difficulty upgrade: Extreme")
	_append_choices(ITEM_CHOICES_EXTREME)

func _append_choices(new_item_choices):
	for choice in new_item_choices:
		item_choices.append(choice)

func _on_game_end():
	if not game_ended:
		game_ended = true
		get_node("AnimationPlayer").play("fade_out")
		get_node("AnimationPlayer").connect("finished", self, "_on_fade_out")

func _on_fade_out():
	get_tree().change_scene("res://scenes/title.scn")