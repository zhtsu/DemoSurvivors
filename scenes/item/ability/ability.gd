class_name Ability
extends Item

@export var active : bool = false

# Make sure call this function once before _ready()
# Otherwise, the action script will not work
func _set_action_gdscript(action_script : Script):
	$Action.set_script(action_script)

