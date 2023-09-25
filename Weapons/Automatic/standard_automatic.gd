extends abstract_weapons

var standard_bullet = load(worldScenes.standard_bullet_automatic)
var speed = 1000
var direction = 1
var base_damage = 2
var can_shoot = true
var pos

func shoot(dir, bullet_typ, my_self):
	if can_shoot:
		direction = dir
		var bullet
		if bullet_typ == "standard":
			bullet = standard_bullet.instantiate()
		else:
			bullet = standard_bullet.instantiate()
		self.get_parent().get_parent().add_child(bullet)
		bullet.shoot(self.get_parent().position + pos, dir, my_self, speed, base_damage)
		can_shoot = false
		$Timer.start()

func setPos(pos):
	super(pos)

func _on_timer_timeout():
	can_shoot = true
