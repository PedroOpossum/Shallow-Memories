extends Control

@onready var tabs := [%Audio, %Resolution, %KeyBindings]
@onready var pages := $Setting_Box/Pages.get_children()

var current_tab := 0


func _ready():

	for i in tabs.size():
		tabs[i].pressed.connect(switch_tab.bind(i))
		tabs[i].focus_mode = Control.FOCUS_ALL

	switch_tab(0)


func _unhandled_input(event):

	if event.is_action_pressed("ui_right"):
		switch_tab(current_tab + 1)

	elif event.is_action_pressed("ui_left"):
		switch_tab(current_tab - 1)

	elif event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Assets/Scenes/Main_Menu_Scene/Main_Menu/Main_Menu.tscn")


func switch_tab(index):

	current_tab = wrapi(index, 0, tabs.size())

	for i in tabs.size():

		var active := i == current_tab

		pages[i].visible = active

		tabs[i].modulate = (
			Color.WHITE
			if active
			else Color(0.5, 0.5, 0.5)
		)
