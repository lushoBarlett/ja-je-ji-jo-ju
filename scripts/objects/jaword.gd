extends RigidBody2D

var GameFunction = "Enemy"

var apuntar: Vector2

const EXPLOSIVENESS = 3

func _ready():
	$AnimationPlayer.play("jagrandote")
	$sfx.play()

func _process(delta):
	apuntar *= 1 + (EXPLOSIVENESS - 1) * delta
	apply_force(apuntar * delta)
	
	# quite arbitrary if you ask me
	if position.length() > 5000:
		queue_free()
