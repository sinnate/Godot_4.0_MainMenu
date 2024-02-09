extends Control
# Please check the documentation about
# Displayserver class : https://docs.godotengine.org/en/stable/classes/class_displayserver.html

#--
# Check out Colorblind addon for godot : https://github.com/paulloz/godot-colorblindness
#--

# Config file
# Move it into a singleton
var settings_file = ConfigFile.new()
#--
var vsync: int = 0
# I'm a Vector3 instead of 3 var float
# - x : General , y : Music , z : SFX
var audio: Vector3 = Vector3(70.0, 70.0, 70.0)



@onready var resolution_option_button = get_node("%Resolution_Optionbutton")
@onready var option_container = get_node("%OptionContainer")
@onready var main_container = get_node("%MainContainer")




func _get_resolution(index) -> Vector2i:
	var resolution_arr = resolution_option_button.get_item_text(index).split("x")
	return Vector2i(int(resolution_arr[0]), int(resolution_arr[1]))


func _check_resolution(resolution: Vector2i):
	for i in resolution_option_button.get_item_count():
		if _get_resolution(i) == resolution:
			return i


func _first_time() -> void:
	DisplayServer.window_set_size(DisplayServer.screen_get_size())
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	DisplayServer.window_set_vsync_mode(vsync)
	resolution_option_button.select(_check_resolution(DisplayServer.screen_get_size()))
	# -- Video
	settings_file.set_value("VIDEO", "Resolution", _get_resolution(resolution_option_button.get_index()))
	settings_file.set_value("VIDEO", "vsync", vsync)
	settings_file.set_value("VIDEO", "Window Mode", _get_resolution(resolution_option_button.get_index()))
	settings_file.set_value("VIDEO", "Graphics", _get_resolution(resolution_option_button.get_index()))
	settings_file.set_value("VIDEO", "Color blind", _get_resolution(resolution_option_button.get_index()))
	# -- audio
	settings_file.set_value("audio", "General", audio.x)
	settings_file.set_value("audio", "Music", audio.y)
	settings_file.set_value("audio", "SFX", audio.z)

	settings_file.save("res://settings.cfg")


func _load_settings():
	if settings_file.load("res://settings.cfg") != OK:
		_first_time()
	else:
		pass


func _save_settings() -> void:
	# -- Video
	settings_file.set_value("VIDEO", "Resolution", _get_resolution(resolution_option_button.get_index()))
	settings_file.set_value("VIDEO", "vsync", vsync)
	settings_file.set_value("VIDEO", "Window Mode", _get_resolution(resolution_option_button.get_index()))
	settings_file.set_value("VIDEO", "Graphics", _get_resolution(resolution_option_button.get_index()))
	settings_file.set_value("VIDEO", "Color blind", _get_resolution(resolution_option_button.get_index()))
	# -- audio
	settings_file.set_value("audio", "General", audio.x)
	settings_file.set_value("audio", "Music", audio.y)
	settings_file.set_value("audio", "SFX", audio.z)

	settings_file.save("res://settings.cfg")


func _ready():
	_load_settings()
	resolution_option_button.select(_check_resolution(DisplayServer.screen_get_size()))


func _on_start_button_pressed():
	# Put your load scene here
	# Check the documentation https://docs.godotengine.org/en/stable/tutorials/scripting/change_scenes_manually.html
	pass  # Replace with function body.


func _on_option_button_pressed():
	option_container.visible = true
	main_container.visible = false


func _on_exit_button_pressed():
	get_tree().quit()


# -- VIDEO TAB --


func _on_resolution_optionbutton_item_selected(index):
	DisplayServer.window_set_size(_get_resolution(index))


func _on_window_mode_optionbutton_item_selected(_index):
	pass  # Replace with function body.


func _on_preset_h_slider_value_changed(_value):
	# start here https://docs.godotengine.org/en/stable/tutorials/3d/mesh_lod.html
	pass  # Replace with function body.


# -- audio TAB --


func _on_general_h_scroll_bar_value_changed(value):
	audio.x = value


func _on_music_h_scroll_bar_value_changed(value):
	audio.y = value


func _on_sfx_h_scroll_bar_value_changed(value):
	audio.z = value


# -- Save and Exit buttons


func _on_return_button_pressed():
	main_container.visible = true
	option_container.visible = false


func _on_apply_button_pressed():
	main_container.visible = true
	option_container.visible = false
	_save_settings()


func _on_vsync_option_button_item_selected(index):
	# check the documentation about vsync : https://docs.godotengine.org/en/stable/classes/class_displayserver.html#enum-displayserver-vsyncmode
	vsync = index
