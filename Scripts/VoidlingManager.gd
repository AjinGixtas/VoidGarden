class_name VoidlingManager extends Node2D

var orbs : Array[Orb] = []
var voidlings : Array[Voidling] = []
var voidling_limits : Array[int] = [-1, -1, -1, -1, 64]
var current_voidling_counts : Array[int] = [0, 0, 0, 0, 0]
var voidling_point_cost : Array[int] = [1, 4, 5, 2, 3]
var current_point : int = 10
var point_bonus : int = 0
@onready var point_display : Label = $"../../CanvasLayer/Label"
enum VOIDLING_TYPE { 
	DESTRUCTIVE_VOIDLING, GATHERER_VOIDLING, GROWTH_VOIDLING, HUNTER_VOIDLING, SWARM_VOIDLING 
}
@export var voidling_scenes : Array[PackedScene] = []
var hunt_target : Voidling
func get_hunt_target(hunter : Voidling) -> Voidling:
	if len(voidlings) < 2: return null
	hunt_target = voidlings[randi_range(0, len(voidlings) - 1)]
	while hunt_target == hunter:
		hunt_target = voidlings[randi_range(0, len(voidlings) - 1)]
	return hunt_target
func get_orb_target() -> Orb:
	if len(orbs) < 1: return null
	return orbs[randi_range(0, len(orbs) - 1)]
func get_scout_target() -> Vector2:
	return Vector2((randf() - .5) * 350, (randf() - .5) * 150)
func on_voidling_killed(voidling : Voidling):
	voidlings.erase(voidling)
	current_voidling_counts[voidling.voidling_type] -= 1
func on_orb_collected(orb : Orb):
	orbs.erase(orb)
	current_point += orb.point_value + point_bonus
	point_display.text = str(current_point)
func spawn_voidling(voidling_type : VOIDLING_TYPE):
	if current_voidling_counts[voidling_type] == voidling_limits[voidling_type] || current_point < voidling_point_cost[voidling_type]: return
	current_point -= voidling_point_cost[voidling_type]
	point_display.text = str(current_point)
	current_voidling_counts[voidling_type] += 1
	voidlings.append(voidling_scenes[voidling_type].instantiate())
	voidlings[len(voidlings) - 1].initialize(voidling_type)
	add_child(voidlings[len(voidlings) - 1])
	voidlings[len(voidlings) - 1].global_position = Vector2((randf() - .5) * 350, (randf() - .5) * 150)
func spawn_swarm(_global_position : Vector2):
	if current_voidling_counts[VOIDLING_TYPE.SWARM_VOIDLING] == voidling_limits[VOIDLING_TYPE.SWARM_VOIDLING]: return
	current_voidling_counts[VOIDLING_TYPE.SWARM_VOIDLING] += 1
	voidlings.append(voidling_scenes[VOIDLING_TYPE.SWARM_VOIDLING].instantiate())
	voidlings[len(voidlings) - 1].initialize(VOIDLING_TYPE.SWARM_VOIDLING)
	add_child(voidlings[len(voidlings) - 1])
	voidlings[len(voidlings) - 1].global_position = _global_position
