extends CharacterBody2D

@onready var raycastFolder = $Raycasts

signal playerDetected

var speed = 200
var accel = 7
var physicsParameters = PhysicsPointQueryParameters2D.new()
var patrolStops = [Vector2(1197,614),Vector2(1197,271),Vector2(950,252),Vector2(950,400),Vector2(939,393),Vector2(831,396),Vector2(831,447),Vector2(938,445),Vector2(938,236),Vector2(211,248),Vector2(211,997),Vector2(402,1002),Vector2(529,1119),Vector2(656,1006),Vector2(834,1011),Vector2(856,891),Vector2(1125,893),Vector2(1197,614),Vector2(1822,621),Vector2(1822,415),Vector2(1509,451),Vector2(1506,346),Vector2(1208,352)]
var currentStop = 0

@onready var nav: NavigationAgent2D = $NavigationAgent2D

func _process(_delta):
	var space_state = get_world_2d().direct_space_state
	for i:RayCast2D in raycastFolder.get_children():
		if i.is_colliding() and i.get_collider() is CharacterBody2D:
			playerDetected.emit()
			#print("playerdetected")
			
func _physics_process(delta):
	physicsParameters.collide_with_areas = true 
	physicsParameters.position = patrolStops[currentStop]
	
	# Add the gravity
	var direction = Vector2()
	if get_world_2d().direct_space_state.intersect_point(physicsParameters, 1):
		currentStop = (currentStop + 1) % patrolStops.size()

	nav.target_position = patrolStops[currentStop]
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, accel * delta)
	rotation = velocity.angle() + (PI/2)
	
	move_and_slide()
