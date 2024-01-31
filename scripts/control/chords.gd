extends AudioStreamPlayer


signal lupie


var rata_muerta = false


func _on_rata_1_muerte(_rata):
	rata_muerta = true


func _on_rata_2_muerte(_rata):
	rata_muerta = true


func _on_secuencia_1_lupie():
	if rata_muerta:
		play()