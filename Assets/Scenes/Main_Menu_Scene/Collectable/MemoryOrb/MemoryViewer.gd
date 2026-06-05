extends Control

signal memory_closed

@onready var artwork_texture_rect: TextureRect = $ArtWork
@onready var memory_text_label: Label = $ArtWork/Text

var memory_data: Dictionary
var current_page_index := 0

func _ready():
	hide()

func open_memory(data: Dictionary):
	memory_data = data
	current_page_index = 0

	artwork_texture_rect.texture = memory_data["artwork"]
	memory_text_label.text = memory_data["text"][0]
	show()

func _unhandled_input(event):

	if not visible:
		return

	if event.is_action_pressed("ui_accept"):

		current_page_index += 1
		get_viewport().set_input_as_handled()

		if current_page_index >= memory_data["text"].size():
			hide()
			memory_closed.emit()
		else:
			memory_text_label.text = memory_data["text"][current_page_index]
