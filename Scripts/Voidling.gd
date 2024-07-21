class_name Voidling extends Node2D 

var velocity : Vector2
@export var move_speed : float
@export var current_health : int
@onready var navigation_agent : NavigationAgent2D = $NavigationAgent2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var sprite : Sprite2D = $Sprite2D

var voidling_manager : VoidlingManager
var voidling_type : VoidlingManager.VOIDLING_TYPE
signal death(voidling : Voidling)
func initialize(_voidling_type : VoidlingManager.VOIDLING_TYPE):
	voidling_type = _voidling_type
func modify_health(modifier : int):
	current_health += modifier
	animation_tree.set("parameters/conditions/isTakingDamage", true)
	if current_health <= 0:
		death.emit(self)
		voidling_manager.on_voidling_killed(self)
		animation_tree.set("parameters/conditions/isDead", true)
func request_safe_velocity(delta : float):
	navigation_agent.velocity = (navigation_agent.get_next_path_position() - global_position).normalized() * move_speed
	position += velocity * delta
func _on_navigation_agent_2d_velocity_computed(safe_velocity : Vector2):
	velocity = safe_velocity
	if velocity.x != 0: sprite.flip_h = velocity.x > 0
