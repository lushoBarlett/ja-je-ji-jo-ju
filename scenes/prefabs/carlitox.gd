extends RigidBody2D

var ratas = []
var GameFunction

@export var SPEED = 200.0

var velocity:Vector2 = Vector2(-SPEED,-SPEED)
# Called when the node enters the scene tree for the first time.
func _ready():
	$cuerpoBoca.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#add_constant_central_force(velocity)
	linear_velocity=velocity
	


func _on_body_entered(body):
	if(body.name == 'borde_sup'):
		#apply_impulse(Vector2(-SPEED,SPEED))
		velocity[1] = SPEED
		#constant_force=(Vector2(SPEED,SPEED))
	elif(body.name == 'borde_inf'):
		velocity[1] = -SPEED
	elif(body.name == 'borde_izq'):
		velocity[0] = SPEED
	elif(body.name == 'borde_der'):
		velocity[0] = -SPEED
			
		
	GameFunction = "Enemy"


func acelerar():
	SPEED += 100
	$AnimationPlayer.play('mover_las_patas')
	$sfx_jojojo.play()

