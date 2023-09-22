extends CharacterBody2D

#movment
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var direction
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#animation
@onready var ANI = get_node("AnimationPlayer")

#life
var is_dead = false
@export var hp = 10

#weapon
var current_weapon
var bullet = "standard"
var looking = 1

#combat
var se_player = false


func _ready():
	#start animation
	ANI.set_current_animation("enemy_idel")
	#start weapon
	set_weapon("res://Weapons/Gun/standard_gun.tscn")

func _physics_process(delta):
	#dead
	if hp <= 0:
		dead()
		return
	
	#combat
	if se_player:
		shoot()
	
	#movment
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()


func dead():
	if !is_dead:
		print("dead, " + str(self.get_name()) + " : " + str(ANI.get_current_animation()))
		is_dead = true
		$CollisionShape2D.disabled = true
		$enemy_1_hitbox.monitoring = false
		$enemy_1_hitbox.monitorable = false
		$vision.monitoring = false
		$vision.monitorable = false
		ANI.set_current_animation("enemy_dead")

func damage(damage):
	hp -= damage

func shoot():
	current_weapon.shoot(looking, bullet, self.get_groups())

func set_weapon(weapon):
	current_weapon = load(weapon).instantiate()
	add_child(current_weapon)
	var p = position
	p.y = 0 - 32
	p.x = 0
	current_weapon.setPos(p)


#signals
func _on_enemy_1_hitbox_area_entered(area):
	pass

func _on_enemy_1_hitbox_area_exited(area):
	pass

func _on_vision_area_entered(area):
	if area.is_in_group("Player_group"):
		print("can se " + area.get_name())
		looking = 1
		if self.position > area.get_parent().position:
			looking = -1
		se_player = true

func _on_vision_area_exited(area):
	if area.is_in_group("Player_group"):
		se_player = false
