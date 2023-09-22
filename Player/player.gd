extends CharacterBody2D
class_name Player

#signals
#signal death()

#move
const SPEED = 300.0
var direction
@export var JUMP_VELOCITY = -400.0
@export var spring_SPEED = SPEED * 1.8
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 2

#weapon
var current_weapon
var bullet = "standard"
var looking = 1

#life
var is_dead = false
@export var hp = 10

#animation
@onready var ANI = get_node("AnimationPlayer")


func _ready():
	#start animation
	ANI.set_current_animation("idel")
	#start weapon
	set_weapon("res://Weapons/Automatic/standard_automatic.tscn")

func _physics_process(delta):
	if is_dead:
		return
	
	#Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	#Handle Jump.
	if Input.is_action_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	#Handle left to rigth movment
	direction = Input.get_axis("vänster", "höger")
	if Input.is_action_pressed("vänster") || Input.is_action_pressed("höger"):
		if direction != 0:
			looking = direction
	if direction:
		if Input.is_action_pressed("spring"):
			velocity.x = direction * spring_SPEED
		else:
			velocity.x = direction * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	#shoot
	if Input.is_action_pressed("skjut"):
		shoot(looking)

func shoot(direction):
	current_weapon.shoot(direction, bullet, self.get_groups())

func set_weapon(weapon):
	current_weapon = load(weapon).instantiate()
	add_child(current_weapon)
	var p = position
	p.y = 0 - 32
	p.x = 0
	current_weapon.setPos(p)

func damage(damage):
	hp -= damage
	if hp <= 0:
		dead()

func dead():
	print("player dead")
	is_dead = true
	worldSignals.emit_signal("player_death")


#signals
func _on_player_hitbox_area_entered(area):
	pass # Replace with function body.

func _on_player_hitbox_area_exited(area):
	if area.get_name() == "Level_area":
		print("player left Level_area")
		dead()
