extends Node

var _can_interact: bool = true

func _ready() -> void:
	pass

func _on_outro_finished() -> void:
	await get_tree().create_timer(0.1).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Assets/Scenes/Main_Menu.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if not _can_interact:
		get_viewport().set_input_as_handled()
		return
	
	if event.is_action_pressed("ui_accept"):
		_can_interact = false
		get_viewport().set_input_as_handled()
		get_tree().paused = true  # freeze entire tree, stops all input processing
		var tween = create_tween()
		tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)  # tween keeps running while paused
		tween.set_parallel()
		tween.tween_property($CanvasLayer/ColorRect, "color", Color(0, 0, 0, 0), 1.0)
		tween.tween_property($CanvasLayer/ColorRect/Warning, "modulate:a", 0.0, 1.0)
		tween.tween_property($CanvasLayer/ColorRect/Text, "modulate:a", 0.0, 1.0)
		tween.tween_property($"CanvasLayer/ColorRect/Enter to fade", "modulate:a", 0.0, 1.0)
		tween.finished.connect(_on_outro_finished)
