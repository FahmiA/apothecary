
extends Node2D

var next_memory_slot_index = 0

func _ready():
	pass

func add_memory(item_1, item_2, item_result):
	print("Remembering mixure ", item_1, " and ", item_2, " to get ", item_result)
	
	var memory_slots = get_tree().get_nodes_in_group("mix_memory_slot")
	
	if not _is_mix_remembered(memory_slots, item_1, item_2, item_result) and not _is_identify_mixure(item_1, item_2):
		var current_memory_slot = _get_next_memory_slot(memory_slots)
		
		current_memory_slot.set_items(item_1, item_2, item_result)
		_highlight_memory_slots(memory_slots, current_memory_slot)

func _get_next_memory_slot(memory_slots):
	var memory_slot = memory_slots[next_memory_slot_index];
	next_memory_slot_index = (next_memory_slot_index + 1) % memory_slots.size()
	
	return memory_slot;

func _highlight_memory_slots(memory_slots, current_memory_slot):
	for memory_slot in memory_slots:
		memory_slot.set_opacity(0.6)
	
	current_memory_slot.set_opacity(1.0)
	
func _is_mix_remembered(memory_slots, item_1, item_2, item_result):
	var remembered = false
	
	for memory_slot in memory_slots:
		if memory_slot.are_items_equal(item_1, item_2, item_result):
			remembered = true
			break
	
	return remembered
	
func _is_identify_mixure(item_1, item_2):
	return item_1 == item_2