extends AudioStreamPlayer

# Luciano: no es igual al script de Drums?

signal lupie

var ult = 0

func _process(_delta):
	if ult > get_playback_position():
		lupie.emit()

	ult = get_playback_position()
