class_name GathererVoidling extends Voidling

var is_gathering : bool = false
var orb_target : Orb
func _ready():
	voidling_manager = get_parent()
	navigation_agent.target_position = voidling_manager.get_scout_target()
func _process(delta):
	if is_gathering:
		get_gathering_target()
		if orb_target == null: 
			is_gathering = false
		if navigation_agent.is_navigation_finished():
			navigation_agent.target_position = voidling_manager.get_scout_target()
			collect()
		request_safe_velocity(delta)
	else:
		if navigation_agent.is_navigation_finished():
			navigation_agent.target_position = voidling_manager.get_scout_target()
		request_safe_velocity(delta)
func get_gathering_target():
	if orb_target != null: return
	orb_target = voidling_manager.get_orb_target()
	if orb_target != null:
		navigation_agent.target_position = orb_target.global_position
func _on_gathering_cooldown_timer_timeout(): is_gathering = true
func collect(): animation_tree.set("parameters/conditions/isCollecting", true)
func collect_behavior():
	if orb_target == null: return
	voidling_manager.on_orb_collected(orb_target)
	orb_target.queue_free()
