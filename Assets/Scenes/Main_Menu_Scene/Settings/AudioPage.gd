extends Control

const SETTINGS_FILE := "user://settings.cfg"

@onready var sliders := {
	"Master": %Master,
	"Music": %Music,
	"SFX": %SFX
}

var loading := true


func _ready():

	load_settings()

	for bus in sliders:
		sliders[bus].value_changed.connect(set_volume.bind(bus))

	loading = false


func set_volume(value: float, bus: String):

	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index(bus),
		linear_to_db(max(value, 0.01))
	)

	if not loading:
		save_settings()


func save_settings():

	var cfg := ConfigFile.new()

	for bus in sliders:
		cfg.set_value("audio", bus, sliders[bus].value)

	cfg.save(SETTINGS_FILE)


func load_settings():

	var cfg := ConfigFile.new()

	if cfg.load(SETTINGS_FILE) != OK:
		set_defaults()
		return

	for bus in sliders:
		sliders[bus].value = cfg.get_value("audio", bus, 1.0)


func set_defaults():

	for bus in sliders:
		sliders[bus].value = 1.0
