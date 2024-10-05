extends CharacterBody2D

@onready var raycastFolder = $Raycasts

var movement_speed: float = 200.0
var movement_target_position: Vector2 = Vector2(60.0,180.0)

var playerInRectangle:bool = false
@export var playerNode: CharacterBody2D

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

	# Make sure to not await during _ready.
	actor_setup.call_deferred()
	

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func _process(_delta):
	var space_state = get_world_2d().direct_space_state
	print("process")
	for i:RayCast2D in raycastFolder.get_children():
		if i.is_colliding() and i.get_collider() is CharacterBody2D:
			print("raycast hit a characterbody")
			
	
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()
