
extends Sprite

const JAR_GROUP = "jar"
const JAR_BROKEN_GROUP = "jar_broken"

func _ready():
	add_to_group(JAR_GROUP)
	
	get_node("sound_timer").connect("timeout", self, "_on_play_sound")

func break_jar(delay):
	add_to_group(JAR_BROKEN_GROUP)
	
	get_node("sound_timer").set_wait_time(delay)
	get_node("sound_timer").start()

func fix_jar(delay):
	remove_from_group(JAR_BROKEN_GROUP)
	
	get_node("sound_timer").set_wait_time(delay)
	get_node("sound_timer").start()

func is_broken():
	return is_in_group(JAR_BROKEN_GROUP)

func _on_play_sound():
	if is_broken():
		get_node("AnimationPlayer").play("break")
		get_node("sound").play("break")
	else:
		get_node("AnimationPlayer").play("fix")
		get_node("sound").play("fix")