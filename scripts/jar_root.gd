
extends Sprite

const JAR_GROUP = "jar"
const JAR_BROKEN_GROUP = "jar_broken"

func _ready():
	add_to_group(JAR_GROUP)

func break_jar():
	add_to_group(JAR_BROKEN_GROUP)
	get_node("AnimationPlayer").play("break")

func fix_jar():
	remove_from_group(JAR_BROKEN_GROUP)
	get_node("AnimationPlayer").play("fix")

func is_broken():
	return is_in_group(JAR_BROKEN_GROUP)
