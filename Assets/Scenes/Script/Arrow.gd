extends TextureRect

@export var menu_parent_path : NodePath
@onready var menu_parent = get_node(menu_parent_path)
var cursor_index : int = 0
@export var cursor_offset : Vector2
signal warning_signal_confirm

func get_menu_item_at_index(index: int) -> Control:
	if menu_parent == null:
		return null
	
	if index >= menu_parent.get_child_count(index) or index < 0:
		return null
	
	return menu_parent.get_child(index) as Control
	
	#This checks all the children of the VBoxContainer

func set_cursor_from_index(index: int) -> void:
	var menu_item := get_menu_item_at_index(index)
	
	if menu_item == null:
		return
	
	var menu_position = menu_item.position
	var menu_size = menu_item.size
	position = menu_position + cursor_offset
	cursor_index = index
	
	#This positions the arrow at the given index
	
func _ready():
	Vector2.ZERO  
	pass  
	
func _process(delta):
	var input := Vector2.ZERO
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("W"):
		input.y -=1
	if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("S"):
		input.y +=1
	set_cursor_from_index(cursor_index + input.y)
	if Input.is_action_just_pressed("ui_accept"):
		var current_menu := get_menu_item_at_index(cursor_index)
		if current_menu != null:
			if current_menu.has_method("cursor_select"):
				current_menu.cursor_select()
	
	# This uses user input to go up and down the labels




