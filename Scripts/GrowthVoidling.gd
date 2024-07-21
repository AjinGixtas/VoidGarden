class_name GrowthVoidling extends Voidling
var current_growth_level : int = 0
var max_growth_level : int = 3
func _ready():
	voidling_manager = get_parent()
	navigation_agent.target_position = voidling_manager.get_scout_target()
func _on_growth_timer_timeout():
	if current_growth_level == max_growth_level: return
	current_growth_level += 1
	voidling_manager.point_bonus += 1
	sprite.frame_coords = Vector2(current_growth_level, 0)
func death_behavior():
	voidling_manager.point_bonus -= current_growth_level 
