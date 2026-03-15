extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.set_loops()  # loop forever
	tween.tween_property(self, "position", position + Vector2(0, -7), 1.0).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position", position + Vector2(0,7), 1.0).set_trans(Tween.TRANS_SINE)
# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
