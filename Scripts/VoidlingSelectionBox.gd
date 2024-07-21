extends Control


@export var texture : Texture2D
@onready var texture_rect : TextureRect = $TextureRect
@export var creature_selection_board : CreatureSelectionBoard
@export var index : int
func _ready():
	texture_rect.texture = texture
func _on_mouse_entered():
	creature_selection_board.change_description_display_content(index)
func _on_pressed():
	creature_selection_board.voidling_manager.spawn_voidling(index)
