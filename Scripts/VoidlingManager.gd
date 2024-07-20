class_name VoidlingManager extends Node2D

var orbs : Array[Orb] = []
var voidlings : Array[Voidling] = []
var voidling_limits : Array[int] = [-1, -1, -1, -1, 40]
var current_voidling_counts : Array[int] = [0, 0, 0, 0, 0]
enum VOIDLING_TYPE { 
	DESTRUCTIVE_VOIDLING, GATHERER_VOIDLING, GROWTH_VOIDLING, HUNTER_VOIDLING, SWARM_VOIDLING 
}
@onready var scout_targets = [$Node2D, $Node2D_2, $Node2D_3, $Node2D_4]
@export var voidling_scenes : Array[PackedScene] = []
func _ready():
	for i in range(4):
		spawn_voidling(VoidlingManager.VOIDLING_TYPE.DESTRUCTIVE_VOIDLING, Vector2(randf() * 100, randf() * 100))
	for i in range(8):
		spawn_voidling(VoidlingManager.VOIDLING_TYPE.HUNTER_VOIDLING, Vector2(randf() * 100, randf() * 100))
	for i in range(4):
		spawn_voidling(VoidlingManager.VOIDLING_TYPE.SWARM_VOIDLING, Vector2(randf() * 100, randf() * 100))
var hunt_target : Voidling
func get_hunt_target(hunter : Voidling) -> Voidling:
	if len(voidlings) < 2: return null
	hunt_target = voidlings[randi_range(0, len(voidlings) - 1)]
	while hunt_target == hunter:
		hunt_target = voidlings[randi_range(0, len(voidlings) - 1)]
	return hunt_target
func get_scout_target() -> Vector2:
	return scout_targets[randi_range(0, len(scout_targets) - 1)].global_position + Vector2(randf_range(-10.0, 10.0), randf_range(-10.0, 10.0))
func on_voidling_killed(voidling : Voidling):
	voidlings.erase(voidling)
	current_voidling_counts[voidling.voidling_type] -= 1
func spawn_voidling(voidling_type : VOIDLING_TYPE, _global_position : Vector2):
	if current_voidling_counts[voidling_type] == voidling_limits[voidling_type]: return
	current_voidling_counts[voidling_type] += 1
	voidlings.append(voidling_scenes[voidling_type].instantiate())
	voidlings[len(voidlings) - 1].initialize(voidling_type)
	add_child(voidlings[len(voidlings) - 1])
	voidlings[len(voidlings) - 1].global_position = _global_position
