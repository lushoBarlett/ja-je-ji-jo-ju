extends RigidBody2D

@export var SPEED = 200.0

@export var Drums: AudioStreamPlayer
@export var Chords: AudioStreamPlayer
@export var Melody1: AudioStreamPlayer
@export var Melody2: AudioStreamPlayer

@onready var Pata = preload("res://scenes/prefabs/Pata.tscn")

var GameFunction = "Enemy"

var ratas := []
var rata : CharacterBody2D
var tiros := 0
var veces := 0
var time_since_shot := 0.0
var direccion_patas : Vector2
var direccion_rata : Vector2
var velocity: Vector2 = Vector2(-SPEED,-SPEED)

func _ready():
	linear_velocity=velocity
	$CuerpoBoca.visible = false


func _process(_delta):
	pass
	
func _physics_process(delta):
	if $AnimationPlayer.is_playing():
		rata = ratas.pick_random()
		direccion_patas = Vector2(0,1).rotated($Patas.rotation).normalized()
		direccion_rata = $Patas.global_position.direction_to(rata.global_position).normalized()
		if(direccion_patas.dot(direccion_rata) >= 0.99):
			if(time_since_shot > 0.1 and tiros <= (ratas.size() + 1)): 
				tiros +=1
				disparar(rata.global_position)
				time_since_shot = 0.0
		time_since_shot += delta



func _on_body_entered(body):
	if(body.name == 'borde_sup'):
		velocity[1] = SPEED

	elif(body.name == 'borde_inf'):
		velocity[1] = -SPEED

	elif(body.name == 'borde_izq'):
		velocity[0] = SPEED

	elif(body.name == 'borde_der'):
		velocity[0] = -SPEED
	linear_velocity=velocity
	
func acelerar():
	$AnimationPlayer.play('mover_las_patas')
	$TimerFinAnimacion.start()
	SPEED += 20
	$sfx_jojojo.play()
	veces += 1

func disparar(dir):
	var pata: RigidBody2D = Pata.instantiate()
	pata.global_position = $Patas.get_global_position()
	pata.apuntar = pata.position.direction_to(dir).normalized() * 300
	pata.rotation = $Patas.rotation
	get_tree().get_root().add_child(pata)

func _on_drums_lupie():

	if veces >= 1 and not Chords.playing:
		Chords.play()
	if veces >= 3 and not Melody1.playing:
		Melody1.play()
	if veces >= 5 and not Melody2.playing:
		Melody2.play()



func _on_timer_fin_animacion_timeout():
	tiros = 0


