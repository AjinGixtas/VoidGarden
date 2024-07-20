extends Control



@export var creature_selection_board : CreatureSelectionBoard
@export var index : int
func _on_mouse_entered():
	creature_selection_board.change_description_display_content(index)

func _on_pressed():
	pass # Replace with function body.
