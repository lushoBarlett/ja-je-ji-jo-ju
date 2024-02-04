extends RigidBody2D

var GameFunction = "Enemy"

var apuntar: Vector2

const EXPLOSIVENESS = 2.5

func _ready():
	apply_impulse(apuntar)
func _process(delta):
	apuntar *= 1 + (EXPLOSIVENESS - 1) * delta
	

	# quite arbitrary if you ask me
	if position.length() > 5000:
		queue_free()
