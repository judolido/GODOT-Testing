extends RayCast3D

func check_interaction() -> void:
	if is_colliding() and Input.is_action_just_pressed("interact"):
		
		var collider := get_collider()
		if collider is Interactable:
			# start_interaction() is described in interactible.gd
			collider.start_interaction()
