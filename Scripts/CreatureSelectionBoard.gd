class_name CreatureSelectionBoard extends Control

@onready var voidling_manager : VoidlingManager = $"../../NavigationRegion2D/VoidlingManager"
@export var description_display : Label
var descriptions : Array[String] = [
	'Cost: 1 Pts, 3 HP, 1 DMG \n Deal 1 self-inflicted damage on attack \n Drop a high-value orb on death with rapidly decreasing value',
	'Cost: 4 Pts, 3 HP \n Run around collect dropped orb',
	'Cost: 5 Pts, 5 HP \n Increasing dropped orb value by 1',
	'Cost: 2 Pts, 3 HP, 1 DMG \n Periodically attack an enemy once and leave.',
	'Cost: 3 Pts, 1 HP \n Duplicate every 5 seconds, cap at 64. \n Drop an orb on death']
func change_description_display_content(index : int):
	description_display.text = descriptions[index]
