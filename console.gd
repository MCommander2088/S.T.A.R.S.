extends Control

@onready var world = $"../"
@onready var textedit = $"Panel/TextEdit"
@onready var label = $Panel/Label
var is_menu_open = false

var coms = []
var c_i = 0 #com_i


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false

func _process(delta: float) -> void:
	if textedit.text.split("\n").size() > 1:
		textedit.text = ""

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
				Input.mouse_mode == Input.MOUSE_MODE_VISIBLE
			else:
				Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
		if event.pressed and event.keycode == KEY_QUOTELEFT:
			toggle_menu()
		if event.pressed and event.keycode == KEY_UP:
			if not abs(c_i) == coms.size():
				c_i -= 1
				textedit.text = coms[c_i]
		if event.pressed and event.keycode == KEY_DOWN:
			if not abs(c_i) == 0:
				c_i += 1
				textedit.text = coms[c_i]
		if event.pressed and event.keycode == KEY_ENTER:
			c_i = 0
			command(textedit.text.split("\n")[0])
			textedit.text = ""
	

func toggle_menu():
	is_menu_open = not is_menu_open  # 反转菜单状态
	self.visible = is_menu_open  # 根据状态显示或隐藏菜单
	if self.visible:
		Input.mouse_mode == Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode == Input.MOUSE_MODE_CAPTURED

func command(com) -> void:
	coms.append(com)
	label.text += "\n>"+com
	if not " " in com:
		if str(com) == "cls":
			label.text = ""
		if str(com) == "list":
			log_info("all objects:")
			for obj in world.objs:
				log_info(obj)
	else:
		com = com.split(" ")
		print(com)
		if com[0] == "create":
			if not com.size() < 8:
				world.new_obj(com[1],com[2],com[3],com[4],com[5],com[6],com[7])
				log_info("created")
			else:
				log_error("size too small")
		
		if com[0] == "print":
			label.text += "\n"+com[1]
		
		if com[0] == "delete":
			world.delete(com[1])
			log_info("deleted "+com[1])
		
		if com[0] == "speed":
			world.speed = float(com[1])

func log_info(text):
	label.text += "\n[info] "+str(text)
func log_error(text):
	label.text += "\n[error] "+str(text)
