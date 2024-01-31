extends RigidBody2D

@export var SPEED = 200.0

@export var Drums: AudioStreamPlayer
@export var Chords: AudioStreamPlayer
@export var Melody1: AudioStreamPlayer
@export var Melody2: AudioStreamPlayer

var GameFunction = "Enemy"

var ratas = []

var veces = 0

var velocity: Vector2 = Vector2(-SPEED,-SPEED)

func _ready():
	$cuerpoBoca.visible = false

func _process(_delta):
	linear_velocity = velocity

func _on_body_entered(body):
	if(body.name == 'borde_sup'):
		velocity[1] = SPEED

	elif(body.name == 'borde_inf'):
		velocity[1] = -SPEED

	elif(body.name == 'borde_izq'):
		velocity[0] = SPEED

	elif(body.name == 'borde_der'):
		velocity[0] = -SPEED

func acelerar():
	SPEED += 20

	$AnimationPlayer.play('mover_las_patas')

	$sfx_jojojo.play()

	veces += 1

func _on_drums_lupie():

	if veces >= 1 and not Chords.playing:
		Chords.play()
	if veces >= 3 and not Melody1.playing:
		Melody1.play()
	if veces >= 5 and not Melody2.playing:
		Melody2.play()

	# Luciano: qué es esto?
	if veces == 1:
		Chords.play()
	if veces == 2:
		Melody1.play()
	if veces == 3:
		Melody2.play()
