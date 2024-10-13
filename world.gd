extends Node3D

@onready var world = $"."

var uninst_obj = preload("res://object.tscn")

var objs = []

var speed = 1.0

func new_obj(x,y,z,v0x,v0y,v0z,mass) -> void:
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
	world.add_child(object)

func _ready() -> void:
	var N3D = Node3D.new()
	N3D.name = "objects"
	world.add_child(N3D)
	new_obj(0,-2,0,2,0,1,100)
	new_obj(0,2,0,-2,-1,0,20)
	new_obj(-2,3,0,-1,2,0,300)
	
func delete(obj_name):
	# 检查元素是否在数组中并删除
	if obj_name in objs:
		objs.erase(obj_name)
	else:
		return false
	get_node(obj_name).queue_free()
