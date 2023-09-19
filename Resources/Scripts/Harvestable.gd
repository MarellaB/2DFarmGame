extends Node2D
class_name Harvestable

@export var resourceGiven: ItemsList.rawItems

@export var refreshTime := 2000

var timeSinceDeath = 0

@export var AliveSprite: Sprite2D
@export var DeadSprite: Sprite2D

var isAlive := false
var spriteChange := false

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (isAlive && spriteChange):
		AliveSprite.visible = true
		DeadSprite.visible = false
		spriteChange = false
	elif (!isAlive && spriteChange):
		AliveSprite.visible = false
		DeadSprite.visible = true
		spriteChange = false
	
	if (timeSinceDeath >= 0 && !isAlive):
		timeSinceDeath -= 1
	
	if (timeSinceDeath <= 0 && !isAlive):
		isAlive = true
		spriteChange = true
		timeSinceDeath = 0

func _physics_process(delta):
	pass

func harvest(player: Player):
	var tempNumber = rng.randf_range(0, 20)
	# Shakes the alive sprite to signify it's been hit
	get_parent().get_node("ShakeEffect").start_shake()
	
	if (tempNumber >= 18):
		isAlive = false
		spriteChange = true
		timeSinceDeath = refreshTime
		# Give Item to Player
	elif (tempNumber >= 8):
		# Give Item to Player
		print("Give Item")
	elif (tempNumber >= 2):
		pass
	else:
		pass
		
