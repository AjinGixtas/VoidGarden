class_name Orb extends Node2D


@export var point_value : int = 1
@export var is_fading : bool = false
@onready var fade_timer : Timer = $FadeTimer
@onready var sprite : Sprite2D = $Sprite2D
func _ready():
	if is_fading: fade_timer.start()

func _fade_timer_timeout():
	point_value -= 1
	if point_value == 0: queue_free()
