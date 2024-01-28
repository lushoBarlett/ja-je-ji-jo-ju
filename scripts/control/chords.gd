extends AudioStreamPlayer

var ult
var HAY_RATA_MUERTA = false
signal lupie

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		

func _on_rata_1_muerte(rata):
	HAY_RATA_MUERTA = true



func _on_secuencia_1_lupie():
	if HAY_RATA_MUERTA:
		play()

