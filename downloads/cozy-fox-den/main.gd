extends Node2D

var player: Vector2 = Vector2(360, 350)
var stone: Vector2 = Vector2(650, 330)
var examined: bool = false
var message: String = "The den is warm. Something has moved the stone."
var message_time: float = 0.0
var speed: float = 190.0


func _ready() -> void:
	_bind("interact", [KEY_E])
	_bind("move_left", [KEY_LEFT, KEY_A])
	_bind("move_right", [KEY_RIGHT, KEY_D])
	_bind("move_up", [KEY_UP, KEY_W])
	_bind("move_down", [KEY_DOWN, KEY_S])
	queue_redraw()


func _bind(action: String, keys: Array) -> void:
	if not InputMap.has_action(action):
		InputMap.add_action(action)
	for k in keys:
		var ev: InputEventKey = InputEventKey.new()
		ev.physical_keycode = k
		InputMap.action_add_event(action, ev)


func _process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	player += direction * speed * delta
	player.x = clampf(player.x, 90.0, 870.0)
	player.y = clampf(player.y, 170.0, 455.0)
	if Input.is_action_just_pressed("interact") and player.distance_to(stone) < 105.0:
		examined = true
		message = "The stone is ordinary. Its position is not."
		message_time = 4.0
	if message_time > 0.0:
		message_time -= delta
	queue_redraw()


func _draw() -> void:
	var font: Font = ThemeDB.fallback_font

	# Warm room and timber alcove.
	draw_rect(Rect2(0, 0, 960, 540), Color("#17151c"))
	draw_rect(Rect2(55, 55, 850, 430), Color("#513b35"))
	draw_rect(Rect2(75, 75, 810, 390), Color("#8a5d48"))
	draw_rect(Rect2(95, 95, 770, 350), Color("#c18b5a"))
	for y in range(115, 440, 44):
		draw_line(Vector2(95, y), Vector2(865, y), Color("#b1774f"), 2.0)
	draw_circle(Vector2(480, 245), 115, Color(0.96, 0.78, 0.47, 0.09))
	draw_circle(Vector2(480, 245), 55, Color(1.0, 0.88, 0.63, 0.12))

	# Doorway and rug.
	draw_rect(Rect2(130, 150, 145, 220), Color("#38272b"))
	draw_rect(Rect2(145, 165, 115, 205), Color("#1e1e2b"))
	_draw_ellipse(Vector2(480, 390), Vector2(300, 65), Color("#6d3f4b"))

	# Fox-shaped Vesper.
	var fox: Color = Color("#b95632")
	draw_circle(Vector2(360, 342), 32, fox)
	draw_colored_polygon(PackedVector2Array([Vector2(335, 320), Vector2(337, 282), Vector2(355, 309)]), fox)
	draw_colored_polygon(PackedVector2Array([Vector2(385, 320), Vector2(383, 282), Vector2(365, 309)]), fox)
	draw_circle(Vector2(349, 338), 4, Color("#f8d28c"))
	draw_circle(Vector2(371, 338), 4, Color("#f8d28c"))
	draw_line(Vector2(350, 354), Vector2(370, 354), Color("#4d2026"), 3.0)
	draw_arc(Vector2(398, 355), 30, -0.5, 1.9, 18, fox, 13.0)

	# Suspicious stone.
	var stone_color: Color = Color("#d3a46d")
	if examined:
		stone_color = Color("#9d7a68")
	draw_circle(stone, 25, stone_color)
	draw_line(stone + Vector2(-12, -3), stone + Vector2(8, -10), Color("#74595a"), 3.0)
	if not examined and player.distance_to(stone) < 105.0:
		draw_arc(stone, 38, 0.0, TAU, 32, Color("#ffe0a0"), 2.0)
		draw_string(font, stone + Vector2(-32, -50), "E  inspect", HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Color("#fff0c2"))

	# Player marker, deliberately simple.
	draw_circle(player, 12, Color("#d9e6b2"))
	draw_circle(player, 5, Color("#2e3641"))

	draw_string(font, Vector2(110, 125), "THE FOX DEN", HORIZONTAL_ALIGNMENT_LEFT, -1, 20, Color("#ffe0a0"))
	draw_string(font, Vector2(110, 425), "Arrow keys / WASD to move   E to inspect", HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Color("#f7d9ae"))
	if message_time > 0.0:
		draw_rect(Rect2(235, 455, 490, 38), Color(0.14, 0.11, 0.15, 0.92), true)
		draw_string(font, Vector2(255, 480), message, HORIZONTAL_ALIGNMENT_LEFT, 450, 16, Color("#ffe9c2"))


func _draw_ellipse(center: Vector2, radius: Vector2, color: Color) -> void:
	var points: PackedVector2Array = PackedVector2Array()
	for i in range(48):
		var angle: float = TAU * float(i) / 48.0
		points.append(center + Vector2(cos(angle) * radius.x, sin(angle) * radius.y))
	draw_colored_polygon(points, color)
