extends RigidBody2D

var ratas = []
var GameFunction
var veces = 0

@export var SPEED = 200.0

@export var DRUMS: AudioStreamPlayer
@export var CHORDS: AudioStreamPlayer
@export var MELO1: AudioStreamPlayer
@export var MELO2: AudioStreamPlayer

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
	SPEED += 20
	$AnimationPlayer.play('mover_las_patas')
	$sfx_jojojo.play()
	veces +=1



func _on_drums_lupie():
	if veces >= 1 and not CHORDS.playing:
		CHORDS.play()
		print('entran chords')
	if veces >= 3 and not MELO1.playing:
		MELO1.play() 
		print('entra melo1')
	if veces >= 5 and not MELO2.playing:
		MELO2.play()
		print('entra melo2')
