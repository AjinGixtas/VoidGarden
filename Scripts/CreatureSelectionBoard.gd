class_name CreatureSelectionBoard extends Control

@export var description_display : Label
var descriptions : Array[String] = ['0','1','2','3','4','5']
func _process(delta):
	pass
func change_description_display_content(index : int):
	description_display.text = descriptions[index]
