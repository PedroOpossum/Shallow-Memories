extends Node


var songs = [
{ "title":"Fly wit me",
  "artist":"Camellia",
  "song":preload("res://Assets/Music/TeraIO_mp3/05 Fly Wit Me.mp3"),
  "scene": ""
},

{ "title":"Dance with Silence",
  "artist":"Camellia",
  "song":preload("res://Assets/Music/TeraIO_mp3/03 Dance with Silence.mp3"),
  "scene": ""
},
{ "title":"Fly wit me",
  "artist":"Kawai Sprite",
  "song":preload("res://Assets/Music/TeraIO_mp3/05 Fly Wit Me.mp3"),
  "scene": ""
},

{ "title":"Fly wit me",
  "artist":"Kawai Sprite",
  "song":preload("res://Assets/Music/TeraIO_mp3/05 Fly Wit Me.mp3"),
  "scene": ""
},
]

func load_level(index: int):
	get_tree().change_scene_to_file(songs[index].scene)
