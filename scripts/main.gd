
extends Control

const ITEM_CHOICES_EASY =	["A", "B", "C", "D"]
const ITEM_CHOICES_MEDIUM =	["AB", "CD"]
const ITEM_CHOICES_HARD =	["ABC"]
const ITEM_CHOICES_EXTREME =["ABCD"]

var item_choices = []

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

	# Bind timer difficulty events
	get_node("timer_easy").connect("timeout", self, "_on_timer_easy")
	get_node("timer_medium").connect("timeout", self, "_on_timer_medium")
	get_node("timer_hard").connect("timeout", self, "_on_timer_hard")
	get_node("timer_extreme").connect("timeout", self, "_on_timer_extreme")
	
	# Bind timer patron spawn events
	get_node("patron_timer").connect("timeout", self, "_on_new_patron")
	
func _on_items_mixed(item):
	get_node("background/arms/AnimationPlayer").play("mix")
	
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