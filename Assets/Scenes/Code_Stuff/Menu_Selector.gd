extends Label

signal cursor_selected
@onready var Start = preload("res://Assets/Scenes/Heaven.tscn")
@onready var Freeplay = preload("res://Assets/Scenes/Freeplay_Screen.tscn")
@onready var Collection = preload("res://Assets/Scenes/Collection_Screen.tscn")
@onready var Settings = preload("res://Assets/Scenes/Settings_Screen.tscn")
func cursor_select()-> void:
	var Name := self.text
	match Name:
		"Start":
			get_tree().change_scene_to_packed(Start) 
			
		"Freeplay":
			get_tree().change_scene_to_packed(Freeplay) 
		"Collection":
			get_tree().change_scene_to_packed(Collection) 
		"Settings":
			get_tree().change_scene_to_packed(Settings)
		"Exit":
			get_tree().quit() 
	pass
	
	#Matches the user input according to the labels names and changes the scene according to it 



