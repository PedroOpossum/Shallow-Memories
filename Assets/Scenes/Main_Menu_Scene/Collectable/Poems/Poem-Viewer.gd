extends Control

@onready var title_label: Label = $ColorRect/Label
@onready var text_label: RichTextLabel = $ColorRect/RichTextLabel


func _ready():
	hide()
	pass

# -------------------------------------------------
# Open poem
# -------------------------------------------------
func open_poem(poem_data: Dictionary):
	
	show()
	title_label.text = poem_data.title
	text_label.text = poem_data.text


