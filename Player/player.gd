extends CharacterBody2D

#move
const SPEED = 300.0
var direction
@export var JUMP_VELOCITY = -400.0
@export var spring_SPEED = SPEED * 1.8
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 2

#shoot
var Bullet = load("res://bulet.tscn")
var look = 1
var can_shoot = true

#animation
@onready var ANI = get_node("AnimationPlayer")


func _ready():
	#start animation
	ANI.set_current_animation("idel")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("vänster", "höger")
	if Input.is_action_pressed("vänster") || Input.is_action_pressed("höger"):
		if direction != 0:
			look = direction
	if direction:
		if Input.is_action_pressed("spring"):
			velocity.x = direction * spring_SPEED
		else:
			velocity.x = direction * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	
	if Input.is_action_pressed("skjut"):
		shoot(look)


func shoot(direction):
	Bullet = load("res://Player/player_bullet.tscn")
	if can_shoot:

		var b = Bullet.instantiate()
		owner.add_child(b)
		var p = position
		p.y = p.y - 32
		b.position = p
		b.direction = direction
		shoot_timer()

func shoot_timer():
	can_shoot = false
	await get_tree().create_timer(0.1).timeout
	can_shoot = true


func _on_player_hitbox_area_entered(area):
	pass # Replace with function body.


func _on_player_hitbox_area_exited(area):
	if area.get_name() == "Level_area":
		#get_tree().change_scene_to_file("res://nivå1.tscn")
		get_tree().get_current_scene()
