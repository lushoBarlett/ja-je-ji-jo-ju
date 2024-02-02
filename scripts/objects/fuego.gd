extends RigidBody2D

var GameFunction = "Enemy"

func _ready():
	$AnimationPlayer.play("fire")

func morir():
	queue_free()