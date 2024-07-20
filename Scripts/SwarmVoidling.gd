class_name SwarmVoidling extends Voidling
@export var orb_scene : PackedScene
func _ready():
	voidling_manager = get_parent()
func _process(delta):
	if navigation_agent.is_navigation_finished():
		navigation_agent.target_position = voidling_manager.get_scout_target()
	request_safe_velocity(delta)
func _on_duplicate_timer_timeout():
	voidling_manager.spawn_voidling(VoidlingManager.VOIDLING_TYPE.SWARM_VOIDLING, global_position)
func death_behavior():
	var orb : Orb = orb_scene.instantiate()
	orb.global_position = global_position
	orb.point_value = 1
	get_parent().add_child(orb)
	get_parent().orbs.append(orb)
	queue_free()
