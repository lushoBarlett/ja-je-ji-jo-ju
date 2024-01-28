extends AudioStreamPlayer

var ult = 0
signal lupie
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if ult > get_playback_position():
		lupie.emit()
		print('lupie')
	ult = get_playback_position()

	
