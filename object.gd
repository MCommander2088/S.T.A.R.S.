extends CharacterBody3D

@onready var parent = $"../"
@onready var selfname = $".".name
var velocity0: Vector3 = Vector3(0,0,0)
var mass = 100

const G = 6.67430*pow(10,-11)#it should be pow(10,-11)


func _ready() -> void:
	print("a new object is added,root name: "+selfname)
	print("delete "+selfname)
	self.velocity = velocity0
	move_and_slide()
	

func _process(delta: float) -> void:
	var speed = parent.speed
	for obj in parent.objs:
		if obj != selfname:
			
			var distance = self.global_transform.origin.distance_to(get_node("../"+obj).global_transform.origin)
			var direction: Vector3 = self.global_transform.origin - get_node("../"+obj).global_transform.origin
			var a_direction: Vector3 = -direction.normalized() * caculate_gravity(get_node("../"+obj).mass,distance)
			if not a_direction.normalized().length() * delta * speed == NAN:
				self.velocity += a_direction.normalized() * delta * speed
				move_and_slide()
			else:
				printerr("error")
			


func caculate_gravity(target_mass,target_distance) -> float:
	return (G*int(target_mass)/(int(target_distance)*int(target_distance)))
	
