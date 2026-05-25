extends Control

const SETTINGS_FILE := "user://settings.cfg"

@onready var binds := {
	"ui_left": %Left,
	"ui_right": %Right,
	"ui_up": %Up,
	"ui_down": %Down
}

var listening_action := ""
var loading := true


func _ready():

	load_binds()

	for action in binds:
		binds[action].pressed.connect(start_rebind.bind(action))

	loading = false


func start_rebind(action: String):

	listening_action = action
	binds[action].text = "PRESS KEY..."


func _input(event):

	if listening_action == "":
		return

	if event is InputEventKey and event.pressed:

		InputMap.action_erase_events(listening_action)
		InputMap.action_add_event(listening_action, event)

		binds[listening_action].text = event.as_text()

		save_binds()

		listening_action = ""


func save_binds():

	var cfg := ConfigFile.new()

	for action in binds:

		var events := InputMap.action_get_events(action)

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

		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, event)

		binds[action].text = event.as_text()
