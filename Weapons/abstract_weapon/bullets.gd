extends Area2D
class_name abstract_bullets

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot(pos, dir, my_self, speed, base_damage):
	self.position = pos
	self.direction = dir
	self.my_self = my_self
	self.speed = speed
	self.base_damage = base_damage

func area_was_entered(area, my_self, base_damage):
	if area.is_in_group(my_self[0]):
		return
	if area.is_in_group("enemies_group"):
		print("hit enemies_group: " + area.get_owner().get_name())
		area.get_owner().damage(base_damage)
		queue_free()
	if area.is_in_group("Player_group"):
		print("hit enemies_group: " + area.get_owner().get_name())
		area.get_owner().damage(base_damage)
		queue_free()
