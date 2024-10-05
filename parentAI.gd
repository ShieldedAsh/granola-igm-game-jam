extends CharacterBody2D

signal contact

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	for i in range(3,23,2):
		var query = PhysicsRayQueryParameters2D.create(global_position, Vector2(100*cos((i * PI)/24) + position.x, -100*sin((i * PI)/24) + position.y))
		var result = space_state.intersect_ray(query)
		if result:
			print("Hit at point: ", result.position)
	
	
