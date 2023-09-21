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

func _ready():
	pass

func _physics_process(delta):
	#dead
	if hp <= 0:
		dead()
		return
	
	#animation
	ANI.play("enemy_idel")
	
	#movment
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()


func dead():
	if !is_dead:
		print("dead, " + str(self.get_name()) + " : " + str(ANI.get_current_animation()) + " .")
		is_dead = true
		$CollisionShape2D.disabled = true
		$enemy_1_hitbox.monitoring = false
		$enemy_1_hitbox.monitorable = false
		$vision.monitoring = false
		$vision.monitorable = false
		ANI.set_current_animation("enemy_dead")


func _on_enemy_1_hitbox_area_entered(area):
	if area.get_name() == "bullet":
		print("hit by " + str(area.get_name()))
		area.queue_free()

func _on_enemy_1_hitbox_area_exited(area):
	pass

func _on_vision_area_entered(area):
	if area.get_name() == "player_hitbox":
		print("can se " + area.get_name())


func _on_enemy_1_hitbox_body_entered(body):
	pass # Replace with function body.
