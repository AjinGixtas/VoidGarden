class_name DestructiveVoidling extends Voidling

var can_attack : bool = false
var is_hunting : bool = false
var hunt_target : Voidling = null
@export var orb_scene : PackedScene
func _ready():
	voidling_manager = get_parent()
	navigation_agent.target_position = voidling_manager.get_scout_target()

func _process(delta):
	if is_hunting:
		get_hunt_target()
		if hunt_target != null:
			if navigation_agent.is_navigation_finished() && can_attack: attack()
			else: request_safe_velocity(delta)
		else: is_hunting = false
	else:
		if navigation_agent.is_navigation_finished():
			navigation_agent.target_position = voidling_manager.get_scout_target()
		request_safe_velocity(delta)

func get_hunt_target():
	if hunt_target == null: 
		hunt_target = voidling_manager.get_hunt_target(self)
		if hunt_target != null && not self.is_connected('death', on_hunt_target_killed): 
			hunt_target.death.connect(on_hunt_target_killed)
func _on_attack_cooldown_timer_timeout(): can_attack = true
func _on_hunt_cooldown_timer_timeout(): is_hunting = true
func _on_update_hunt_target_position_timer_timeout():
	if is_hunting and hunt_target != null: navigation_agent.target_position = hunt_target.global_position
func attack(): animation_tree.set("parameters/conditions/isAttacking", true)
func attack_behavior(): 
	if hunt_target == null: return
	hunt_target.modify_health(-1)
	modify_health(-1)
func on_hunt_target_killed(_hunt_target : Voidling): hunt_target = null
func death_behavior():
	var orb : Orb = orb_scene.instantiate()
	orb.global_position = global_position
	orb.point_value = 10
	orb.is_fading = true
	get_parent().add_child(orb)
	get_parent().orbs.append(orb)
	queue_free()
