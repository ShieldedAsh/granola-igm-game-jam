extends CharacterBody2D
#PhysicsDirectSpaceState2d::intersect_point()

var speed = 300
var accel = 7
var pp = PhysicsPointQueryParameters2D.new()
var patrolDirec = "Forwards"


@onready var nav: NavigationAgent2D = $NavigationAgent2D

func _ready():
	pp.collide_with_areas = true 
	pp.position = Vector2(425,497)

func _physics_process(delta: float) -> void:
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	for i in range(3,23,2):
		var angle = (7.5 * i * PI) - rotation
		var query = PhysicsRayQueryParameters2D.create(global_position, Vector2(100 * cos(angle)+position.x, -100 * sin(angle)+position.y))
		var result = space_state.intersect_ray(query)
		if result:
			print("Hit at point: ", result.position)
	var direction = Vector3()

	if (patrolDirec == "Forwards" && get_world_2d().direct_space_state.intersect_point(pp,1)):
		patrolDirec = "Backwards"
		pp.position = Vector2(957,507)
	elif (patrolDirec == "Backwards" && get_world_2d().direct_space_state.intersect_point(pp,1)):
		patrolDirec = "Forwards"
		pp.position = Vector2(425,497)
	

	nav.target_position = pp.position
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, accel * delta)
	
	move_and_slide()
	
