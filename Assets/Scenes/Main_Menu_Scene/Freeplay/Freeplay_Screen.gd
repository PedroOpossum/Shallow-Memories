extends Control

var buttons: Array[TextureButton] = []
var selected_index := 0
var tween: Tween

@onready var title_label: Label = $InfoPanel/SongTitle
@onready var artist_label: Label = $InfoPanel/Artist
@onready var music: AudioStreamPlayer = $InfoPanel/Song

const SPACING := 160

const COLOR_ON := Color.WHITE
const COLOR_OFF := Color(0.35, 0.35, 0.35, 1)

const SCALE_ON := Vector2(2.0, 2.0)
const SCALE_OFF := Vector2(1.2, 1.2)





func _ready():
	for node in find_children("*", "TextureButton", true, false):
		buttons.append(node)

	if buttons.is_empty():
		return

	_select(0)


func _unhandled_input(e):
	if buttons.is_empty():
		return

	if e.is_action_pressed("ui_down"):
		_change(1)

	elif e.is_action_pressed("ui_up"):
		_change(-1)

	elif e.is_action_pressed("ui_accept"):
		Levels.load_level(selected_index)
	elif e.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file(
			"res://Assets/Scenes/Main_Menu_Scene/Main_Menu/Main_Menu.tscn"
		)


func _change(dir: int):
	selected_index = clamp(selected_index + dir, 0, Levels.songs.size() - 1)
	_select(selected_index)


func _select(i: int):
	selected_index = i

	if tween:
		tween.kill()

	for j in buttons.size():
		var b := buttons[j]
		var offset := j - selected_index
		var active := j == selected_index

		b.position = Vector2(0, offset * SPACING)

		b.modulate = COLOR_ON if active else COLOR_OFF
		b.scale = SCALE_ON if active else SCALE_OFF

		if active:
			title_label.text = Levels.songs[i].title
			artist_label.text = Levels.songs[i].artist
			tween = create_tween()
			
			# button scale
			tween.parallel().tween_property(
				b,
				"scale",
				Vector2(2.1, 2.1),
				0.08
			)
			# title pop
			title_label.scale = Vector2(0.9, 0.9)
			tween.parallel().tween_property(
				title_label,
				"scale",
				Vector2.ONE,
				0.1
			)
			# artist pop
			artist_label.scale = Vector2(0.9, 0.9)
			tween.parallel().tween_property(
				artist_label,
				"scale",
				Vector2.ONE,
				0.1
			)
			_play_song(i)

var current_song := -1
var audio_tween: Tween
func _play_song(i: int):
	if i == current_song:
		return

	current_song = i

	if audio_tween:
		audio_tween.kill()

	audio_tween = create_tween()


	audio_tween.tween_callback(func():
		music.stream = Levels.songs[i].song
		music.play()
	)
