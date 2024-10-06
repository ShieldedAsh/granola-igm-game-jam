extends CharacterBody2D

@onready var raycastFolder = $Raycasts

var speed = 300
var accel = 7
var physicsParameters = PhysicsPointQueryParameters2D.new()
var patrolStops = [Vector2(81,61),Vector2(81,569),Vector2(974,565),Vector2(974,112),Vector2(584,106),Vector2(578,349)]
var currentStop = 4
var stopDirection = 1

@onready var nav: NavigationAgent2D = $NavigationAgent2D

func _process(_delta):
	var space_state = get_world_2d().direct_space_state
	for i:RayCast2D in raycastFolder.get_children():
		if i.is_colliding() and i.get_collider() is CharacterBody2D:
			print("raycast hit a characterbody")
			
func _physics_process(delta):
	physicsParameters.collide_with_areas = true 
	physicsParameters.position = get_global_mouse_position()
	
	# Add the gravity
	var direction = Vector2()
	if get_world_2d().direct_space_state.intersect_point(physicsParameters, 1):
		print("HIT")
		if (currentStop == 0 || currentStop == 5):
			stopDirection *= -1
		currentStop += stopDirection

	nav.target_position = patrolStops[currentStop]
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, accel * delta)
	
	move_and_slide()
