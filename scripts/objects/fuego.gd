extends RigidBody2D

var GameFunction = "Enemy"

func _ready():
	$AnimationPlayer.play("money")

func morir():
	queue_free()