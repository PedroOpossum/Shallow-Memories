extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Assets/Scenes/Main_Menu.tscn") 	
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("W"):
		pass
	if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("S"):
		pass
	pass
