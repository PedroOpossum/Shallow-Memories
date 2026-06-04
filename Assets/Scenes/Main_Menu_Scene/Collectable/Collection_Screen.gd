extends Control

var buttons: Array[TextureButton] = []
var selected_index := 0

@onready var poem_viewer = $PoemView

func _ready():
	buttons.clear()
	for node in find_children("*", "TextureButton", true, false):
		if node is TextureButton:
			buttons.append(node)
	for i in buttons.size():
		buttons[i].focus_mode = Control.FOCUS_ALL
		buttons[i].focus_entered.connect(_on_focus.bind(i))
	if buttons.size() > 0:
		buttons[0].grab_focus()
		await get_tree().process_frame
		_on_focus(0)

func _on_focus(index: int):
	selected_index = index
	for i in buttons.size():
		var tween = buttons[i].create_tween()
		tween.tween_property(
			buttons[i],
			"modulate",
			Color.WHITE if i == index else Color(0.35, 0.35, 0.35, 1),
			0.15
		)

func _open_collectible(button: TextureButton):
	var key = button.name
	if Poems.poems.has(key):  
		$Main_UI.hide()
		poem_viewer.open_poem(Poems.poems[key])


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		if buttons.size() == 0:
			return
		_open_collectible(buttons[selected_index])
	if event.is_action_pressed("ui_cancel"):
		if poem_viewer.visible:
			poem_viewer.hide()
			$Main_UI.show()
			buttons[selected_index].grab_focus()
		else:
			get_tree().change_scene_to_file("res://Assets/Scenes/Main_Menu_Scene/Main_Menu/Main_Menu.tscn")
