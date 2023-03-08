extends Label



func _ready():
	self.text= str(get_parent().value) + "%"

func _on_h_scroll_bar_value_changed(value):
	self.text = str(value) + "%"
