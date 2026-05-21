extends Node


var scenes := {
	"Level 1": "res://Assets/Scenes/Levels/Level1.tscn",
	"Level 2": "res://Assets/Scenes/Levels/Level2.tscn",
	"Level 3": "res://Assets/Scenes/Levels/Level3.tscn"
}

func load_level(name: String) -> void:
	if scenes.has(name):
		get_tree().change_scene_to_file(scenes[name])
	else:
		push_warning("Level not found: " + name)
