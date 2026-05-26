extends Control

const SETTINGS_FILE := "user://settings.cfg"

@onready var binds := {
	"ui_left": %Left,
	"ui_right": %Right,
	"ui_up": %Up,
	"ui_down": %Down
}

var listening := ""


func _ready():

	load_binds()

	for action in binds:

		binds[action].pressed.connect(
			start_rebind.bind(action)
		)

		update_text(action)


func start_rebind(action: String):

	listening = action
	binds[action].text = "PRESS KEY..."


func _input(event):

	if listening == "":
		return

	if event is InputEventKey and event.pressed:

		set_bind(listening, event)
		save_binds()

		listening = ""


func set_bind(action: String, event: InputEventKey):

	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, event)

	update_text(action)


func update_text(action: String):

	var events: Array[InputEvent] = InputMap.action_get_events(action)

	if events.size() > 0:
		binds[action].text = events[0].as_text()


func save_binds():

	var cfg := ConfigFile.new()

	for action in binds:

		var events: Array[InputEvent] = InputMap.action_get_events(action)

		if events.size() > 0:
			cfg.set_value("binds", action, events[0].keycode)

	cfg.save(SETTINGS_FILE)


func load_binds():

	var cfg := ConfigFile.new()

	if cfg.load(SETTINGS_FILE) != OK:
		return

	for action in binds:

		var keycode: int = cfg.get_value("binds", action, 0)

		if keycode == 0:
			continue

		var event := InputEventKey.new()
		event.keycode = keycode

		set_bind(action, event)
