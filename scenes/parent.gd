extends CharacterBody2D

@onready var raycastFolder = $Raycasts

var speed = 300
var accel = 7
var physicsParameters = PhysicsPointQueryParameters2D.new()
var patrolStops = [Vector2(114,101),Vector2(115,520),Vector2(1009,528),Vector2(1015,95),Vector2(572,95),Vector2(565,345)]
var currentStop = 4
var stopDirection = -1

@onready var nav: NavigationAgent2D = $NavigationAgent2D

func _process(_delta):
	var space_state = get_world_2d().direct_space_state
	for i:RayCast2D in raycastFolder.get_children():
		if i.is_colliding() and i.get_collider() is CharacterBody2D:
			print("raycast hit a characterbody")
			
func _physics_process(delta):
	physicsParameters.collide_with_areas = true 
	physicsParameters.position = patrolStops[currentStop]
	
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
