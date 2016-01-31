
extends Node2D

const CORRECT_ITEM_BONUS = 2
const INCORRECT_ITEM_PENALTY = 1

const ITEM_DIFFICULTY_MULTIPLIER = 1.5

func _ready():
	add_user_signal("all_jars_broken")

func _on_correct_item_recieved(item):
	var broken_jars = _get_broken_jars()
	
	var bonus_jar_count = get_jar_bonus(CORRECT_ITEM_BONUS, item.get_item())
	var jars_to_fix = min(broken_jars.size(), bonus_jar_count)

	for i in range(jars_to_fix, 0, -1):
		var jar = broken_jars[i - 1]
		var delay = 0.5 * i
		
		jar.fix_jar(delay)
	
func _on_patron_patience_expired(item_code):
	var fixed_jars = _get_fixed_jars()
	
	var penalty_jar_count = get_jar_bonus(INCORRECT_ITEM_PENALTY, item_code)
	var jars_to_break = min(fixed_jars.size(), penalty_jar_count)

	for i in range(jars_to_break, 0, -1):
		var jar = fixed_jars[i - 1]
		var delay = 0.5 * i
		
		jar.break_jar(delay)
		
func get_jar_bonus(penalty, item_code):
	return floor(penalty * ITEM_DIFFICULTY_MULTIPLIER * item_code.length())

func _get_broken_jars():
	return get_tree().get_nodes_in_group("jar_broken")

func _get_fixed_jars():
	var jars = get_tree().get_nodes_in_group("jar")
	var fixed_jars = []
	
	for jar in jars:
		if not jar.is_broken():
			fixed_jars.append(jar)
	
	return fixed_jars