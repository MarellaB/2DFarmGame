extends CharacterBody2D
class_name Player

const speed = 500
const useTimeout = 0.5

var inventory = []

var leftArmPos
var rightArmPos

var leftClick = false
var leftClickTimeout = 0

var rightClick = false
var rightClickTimeout = 0

var targetInteractable: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	leftArmPos = get_node("Hands/Left").position
	rightArmPos = get_node("Hands/Right").position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	# All controlls are handled in this function
	_handle_input(delta)
	_handle_arms(delta)
	look_at(get_global_mouse_position())

func addToInv(item):
	inventory.append(item)

# Handles initial inputs, needs called via physics process
func _handle_input(delta):
	if Input.is_action_just_pressed("Interact"):
		print(inventory)
		
	var temp = speed * delta
	if Input.is_action_pressed("MoveUp"):
		move_and_collide(Vector2(0, -temp))
	elif Input.is_action_pressed("MoveDown"):
		move_and_collide(Vector2(0, temp))
		
	if Input.is_action_pressed("MoveRight"):
		move_and_collide(Vector2(temp, 0))
	elif Input.is_action_pressed("MoveLeft"):
		move_and_collide(Vector2(-temp, 0))
	
	leftClick = Input.is_action_pressed("PrimaryAction")
	rightClick = Input.is_action_pressed("SecondaryAction")


# Controlls arm movement (and actions)
func _handle_arms(delta):
	var leftArm: Area2D = get_node("Hands/Left")
	if (leftClick && leftClickTimeout <= 0):
		leftClickTimeout = useTimeout
		get_node("Hands/Left").position = Vector2(48, leftArmPos.y)
		if (targetInteractable != null):
			if (targetInteractable.has_node("HarvestableNode")):
				targetInteractable.get_node("HarvestableNode").harvest()
	
	if (leftClickTimeout > 0):
		leftClickTimeout -= delta
		if (leftClickTimeout <= 0):
			get_node("Hands/Left").position = Vector2(leftArmPos.x, leftArmPos.y)
	
	if (rightClick && rightClickTimeout <= 0):
		rightClickTimeout = useTimeout
		get_node("Hands/Right").position = Vector2(48, rightArmPos.y)
	
	if (rightClickTimeout > 0):
		rightClickTimeout -= delta
		if (rightClickTimeout <= 0):
			get_node("Hands/Right").position = Vector2(rightArmPos.x, rightArmPos.y)


func _on_interaction_area_area_entered(area):
	targetInteractable = area
	print("Assigned Area")
	print(targetInteractable)
