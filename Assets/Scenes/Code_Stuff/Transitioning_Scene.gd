extends Node
var Main_Menu := preload("res://Assets/Scenes/Main_Menu.tscn").instantiate()
@export var animation_played=true


func _ready():
	$Transitioning_Phase.stop()
	
	pass 
	
func _process(delta):

	if Input.is_action_just_pressed("ui_accept") and animation_played:
		$Transitioning_Phase.play("Transition")
		animation_played = false
		get_tree().change_scene_to_file("res://Assets/Scenes/Main_Menu.tscn") 	
		
		
		
		
	pass


	
