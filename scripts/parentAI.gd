extends CharacterBody2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	for i in range(3,23,2):
		var angle = (7.5 * i * PI) - rotation
		var query = PhysicsRayQueryParameters2D.create(global_position, Vector2(100 * cos(angle)+position.x, -100 * sin(angle)+position.y))
		var result = space_state.intersect_ray(query)
		if result:
			print("Hit at point: ", result.position)
	
