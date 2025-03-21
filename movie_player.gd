extends Control
class_name MoviePlayer

#data members are set / defined by the _set_args function, which will create a video player, slap it on top of the current scene, and play the video file
var next_scene_name:String
var video : VideoStreamTheora
var video_player:VideoStreamPlayer
var skip_button:Button
var is_skippable:bool
var tree:SceneTree
var container : AspectRatioContainer
signal movie_ended

func set_args(tree_in : SceneTree, next_scene : String = "", movie_path : String = "res://assets/videos/logos/qcdev.ogv", loop_video : bool = false, skippable:bool = true) -> bool: #return success
	if tree_in ==null: #invalid argument
		return false

	next_scene_name = next_scene
	is_skippable = skippable
	tree = tree_in
	set_process_input(true)
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# create container, add to scenetree, and stretch the shid out of it
	container = AspectRatioContainer.new()
	container.ratio = 16.0/9.0
	tree.root.add_child(container)
	container.anchor_left = 0.0
	container.anchor_right = 1.0
	container.anchor_top = 0.0
	container.anchor_bottom = 1.0
	
	#create stream & stream player, apply loop arg
	video_player = VideoStreamPlayer.new()
	video = VideoStreamTheora.new()
	video.set_file(movie_path)
	video_player.stream = video
	video_player.loop = loop_video

	#anchor videostreamplayer to container
	container.add_child(video_player)
	video_player.expand = true
	video_player.anchor_left = 0.0
	video_player.anchor_right = 1.0
	video_player.anchor_top = 0.0
	video_player.anchor_bottom = 1.0
	
	if is_skippable:
		#create skip button, add to scene tree, set size, pos, & text, connect new button signal to pressed event
		skip_button = Button.new()
		skip_button.pressed.connect(_on_skip_button_pressed)
		tree.root.add_child(skip_button)
		skip_button.text = "SKIP"
		skip_button.get_transform().get_scale().x = 256.0
		skip_button.get_transform().get_scale().y = 48.0
		skip_button.anchor_left = 0.0
		skip_button.anchor_bottom = 1.0
		skip_button.anchor_right = 0.3
		skip_button.anchor_top = .9
		#skip button is off by default until certain inputs are made
		skip_button.visible = false
		skip_button.disabled = true
		skip_button.visibility_layer = video_player.visibility_layer+1

	#connect finished signal to func & play movie
	video_player.finished.connect(_on_video_stream_player_finished)
	video_player.play()
	return true #success

func _on_skip_button_pressed() -> void:
	if is_skippable && skip_button.visible == true:
		video_player.finished.disconnect(_on_video_stream_player_finished)
		skip_button.pressed.disconnect(_on_skip_button_pressed)
		destroy()

func _on_video_stream_player_finished() -> void:
	if video_player.loop == false:
		video_player.finished.disconnect(_on_video_stream_player_finished)
		skip_button.pressed.disconnect(_on_skip_button_pressed)
		destroy()

#make sure the parent scene calls this via its own _input() function
func read_input_from_scene(event: InputEvent) -> void:
	if event.is_action_pressed("Pause") or event.is_action_pressed("Click") or event.is_action_pressed("Phone"):
		if is_skippable:
			skip_button.visible = true
			skip_button.disabled = false
			

func destroy(): #remove nodes from window & free data
	movie_ended.emit()
	if video_player:
		video_player.visible = false
		if tree && container:
			container.remove_child(video_player)
		video_player.queue_free()
	if container:
		if tree:
			tree.root.remove_child(container)
		container.queue_free()
	if skip_button:
		skip_button.visible = false
		if tree:
			tree.root.remove_child(skip_button)
		skip_button.queue_free()
	if next_scene_name.length() > 0: 
		queue_free()
		GlobalManager.load_scene(next_scene_name)
		return
		
	queue_free()
