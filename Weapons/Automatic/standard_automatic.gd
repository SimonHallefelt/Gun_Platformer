extends Node2D

var standard_bullet = load("res://Weapons/Automatic/standard_bullet.tscn")
var speed = 1000
var direction = 1
var base_damage = 2
var can_shoot = true

func shoot(dir, bullet_typ, my_self):
	if can_shoot:
		direction = dir
		var bullet
		if bullet_typ == "standard":
			bullet = standard_bullet.instantiate()
		else:
			bullet = standard_bullet.instantiate()
		self.get_parent().get_parent().add_child(bullet)
		bullet.shoot(self.get_parent().position + position, dir, my_self, speed)
		can_shoot = false
		$Timer.start()

func setPos(pos):
	position = pos

func _on_timer_timeout():
	can_shoot = true
