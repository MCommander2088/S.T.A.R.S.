extends CharacterBody3D

@onready var console = $"../Console"

# How fast the player moves in meters per second.
@export var speed = 3

var target_velocity = Vector3.ZERO

@export var rotation_speed : float = 1.0  # 旋转速度

func _process(delta: float) -> void:
	if console.visible:
		return
	var rotation_input = Vector2.ZERO
	# 检测键盘输入
	if Input.is_key_pressed(KEY_Q):  # Q 键
		rotation_input.x += 1
	if Input.is_key_pressed(KEY_E):  # E 键
		rotation_input.x -= 1

	# 根据输入旋转摄像头
	rotation.y += rotation_input.x * rotation_speed * delta

	# 限制垂直旋转（可以根据需求修改）
	rotation.y = clamp(rotation.y, -1.5, 1.5)  # 限制为 -90 到 90 度（弧度）

func _physics_process(delta) -> void:
	if console.visible:
		return
	var direction = Vector3.ZERO
	var extra_speed = 1

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_pressed("move_up"):
		direction.y += 1
	if Input.is_action_pressed("move_down"):
		direction.y -= 1
	
	
	
	if Input.is_action_pressed("shift"):
		extra_speed = 3
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		#self.basis = Basis.looking_at(direction)

	# Ground Velocity
	target_velocity.x = direction.x * speed * extra_speed
	target_velocity.z = direction.z * speed * extra_speed
	target_velocity.y = direction.y * speed * extra_speed


	# Moving the Character
	velocity = target_velocity
	move_and_slide()
