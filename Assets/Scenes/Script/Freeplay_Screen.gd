extends Control


@onready var items: Array = $VBoxContainer.get_children()

var current_index: int = 0
var tween: Tween

const CENTER_SCALE := Vector2.ONE
const SIDE_SCALE := Vector2(0.7, 0.7)

const CENTER_ALPHA := 1.0
const SIDE_ALPHA := 0.4

const TWEEN_DURATION := 0.25


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	update_visuals(true)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Assets/Scenes/Main_Menu.tscn")

	elif event.is_action_pressed("ui_up"):
		move_selection(-1)

	elif event.is_action_pressed("ui_down"):
		move_selection(1)
		
func move_selection(direction: int) -> void:
	current_index = wrapi(current_index + direction, 0, items.size())
	update_visuals()


func update_visuals(instant: bool = false) -> void:

	if tween:
		tween.kill()

	tween = create_tween()
	tween.set_parallel(true)

	for i in range(items.size()):
		var item: TextureRect = items[i]
		var is_selected := i == current_index

		var target_scale := CENTER_SCALE if is_selected else SIDE_SCALE
		var target_alpha := CENTER_ALPHA if is_selected else SIDE_ALPHA

		if instant:
			item.scale = target_scale
			item.modulate.a = target_alpha
		else:
			tween.tween_property(item, "scale", target_scale, TWEEN_DURATION)
			tween.tween_property(item, "modulate:a", target_alpha, TWEEN_DURATION)
