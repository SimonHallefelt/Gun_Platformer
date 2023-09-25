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
@export var max_hp = 10
var hp = max_hp

#hp_bar
@onready var hpBar = $ui/hp_bar
var color_green = Color(0, 1, 0.1176, 1) #00ff1e
var color_yellow = Color(0.9, 0.9, 0, 1)
var color_red = Color(1, 0, 0, 1)

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
	set_weapon(worldScenes.standard_gun)
	#hp_bar
	hpBar.max_value = max_hp
	hpBar.value = max_hp

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
		$ui.visible = false
		ANI.set_current_animation("enemy_dead")

func damage(damage):
	hp -= damage
	hpBar.value = hp
	if hp > max_hp * 0.7:
		hpBar.tint_progress = color_green
	elif hp > max_hp * 0.3:
		hpBar.tint_progress = color_yellow
	else:
		hpBar.tint_progress = color_red

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
