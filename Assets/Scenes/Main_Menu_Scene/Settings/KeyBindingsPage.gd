extends Control

const SETTINGS_FILE := "user://settings.cfg"

@onready var binds := {
	"ui_up": %UpButton,
	"ui_left": %LeftButton,
	"ui_down": %DownButton,
	"ui_right": %RightButton,
}

var listening := ""


func _ready():

	load_binds()

	for action in binds:

		binds[action].pressed.connect(
			func():
				listening = action
				binds[action].text = "PRESS KEY..."
		)

		update_text(action)


func _input(event):

	if listening.is_empty():
		return

	if !(event is InputEventKey):
		return

	if not event.pressed or event.echo:
		return

	# Ignore button activation keys
	if event.keycode in [KEY_ENTER, KEY_KP_ENTER, KEY_SPACE]:
		return

	# Remove this key from every action
	for action in binds:

		for e in InputMap.action_get_events(action):

			if e is InputEventKey and e.keycode == event.keycode:
				InputMap.action_erase_event(action, e)

				update_text(action)

	# Set new bind
	InputMap.action_erase_events(listening)
	InputMap.action_add_event(listening, event)

	update_text(listening)
	save_binds()

	listening = ""


func get_key_text(event: InputEventKey) -> String:

	match event.keycode:

		KEY_UP:
			return "↑"

		KEY_DOWN:
			return "↓"

		KEY_LEFT:
			return "←"

		KEY_RIGHT:
			return "→"

		_:
			return event.as_text()


func update_text(action: String):

	var events := InputMap.action_get_events(action)

	binds[action].text = (
		get_key_text(events[0])
		if not events.is_empty()
		else "-"
	)


func save_binds():

	var cfg := ConfigFile.new()

	for action in binds:

		var events := InputMap.action_get_events(action)

		if not events.is_empty():

			cfg.set_value(
				"binds",
				action,
				events[0].keycode
			)

	cfg.save(SETTINGS_FILE)


func load_binds():

	var cfg := ConfigFile.new()

	if cfg.load(SETTINGS_FILE) != OK:
		return

	for action in binds:

		var key: int = cfg.get_value("binds", action, 0)

		if key == 0:
			continue

		var event := InputEventKey.new()
		event.keycode = key

		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, event)

		update_text(action)
