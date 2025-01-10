extends Interactable
class_name Pickapable
#pickapable extends from Interactable (which is now under Area3D)
#ItemConfig is accessible due to the ClassName is used


@export var item_key : ItemConfig.Keys

@onready var parent : Node3D = get_parent()

func start_interaction() -> void:
	parent.queue_free()
