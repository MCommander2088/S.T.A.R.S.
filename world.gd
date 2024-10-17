extends Node3D

@onready var world = $"."
@onready var camera = $Camera

var camera_statue = "free"

var uninst_obj = preload("res://object.tscn")

var objs = []

var speed = 1.0

func new_obj(x,y,z,v0x,v0y,v0z,mass) -> void:
	var objects_node = get_node("./objects")
	
	var object = uninst_obj.instantiate()
	var obj_name = "obj_"+str(randi()).substr(0, 8)
	
	while true:
		if obj_name in objs:
			obj_name = "obj_"+str(randi()).substr(0, 8)
		else:
			break
	objs.append(obj_name)
		
	object.name = obj_name
	object.position.x = int(x)
	object.position.y = int(y)
	object.position.z = int(z)
	
	object.velocity0 = Vector3(int(v0x),int(v0y),int(v0z))
	
	object.mass = mass
	objects_node.add_child(object)

func _ready() -> void:
	var N3D = Node3D.new()
	N3D.name = "objects"
	world.add_child(N3D)
	new_obj(0,0,0,2,0,1,120)
	new_obj(0,2,0,-2,-1,0,10)
	new_obj(-2,3,0,-1,2,0,300)
	
func _process(delta: float) -> void:
	if not camera_statue == "free":
		if not typeof(get_node("objects/"+camera_statue)) == 24:
			camera.position = get_node("objects/"+camera_statue).position

func delete(obj_name):
	# 检查元素是否在数组中并删除
	if obj_name in objs:
		objs.erase(obj_name)
	else:
		return false
	get_node(obj_name).queue_free()

func delete_all():
	get_node("objects").queue_free()
	var N3DD = Node3D.new()
	N3DD.name = "objects"
	world.add_child(N3DD)
	objs = []
