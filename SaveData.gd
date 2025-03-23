extends Resource
class_name SaveData

@export var resolutionsList = {
	"2560 x 1440": Vector2i(2560,1440),
	"1920 x 1080": Vector2i(1920,1080),
	"1280 x 720": Vector2i(1280,720),
	"960 x 540": Vector2i(960,540),
	"854 x 480": Vector2i(854,480),
	"640 x 360": Vector2i(640,360)
}

# @export var isFullscreen : bool = false
@export var isVSync : bool = false
@export var resolution : Vector2i = Vector2i(1280,720)
@export var resolutionString : String = "1280 x 720"
@export var volumeScaleMaster : float = 1.0   #scales from 0.0 to 1.0
@export var volumeScaleMusic : float = 1.0
@export var volumeScaleSFX : float = 1.0
@export var sceneName : String = ""
@export var playerName: String = ""
@export var flies: int = 10
@export var timeOfDay = 3
@export var dayNumber = 0

#frog data

@export var frog_names = ["Sassy Twink", "Laid-back", "Cowboy"]
@export var frog_affinity = [20, 25, 15]
