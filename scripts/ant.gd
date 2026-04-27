extends Node2D
class_name Ant

var energy: float = 45.0
var age: float = 0.0
var direction: Vector2 = Vector2.RIGHT
var speed: float = 40.0
var wander_timer: float = 0.0

func _ready() -> void:
	_pick_new_direction()

func tick(delta: float, food_positions: Array[Vector2], play_area: Rect2) -> Dictionary:
	age += delta
	energy -= delta * 1.4

	var movement := direction * speed * delta
	if not food_positions.is_empty():
		var nearest_food := _nearest(food_positions)
		var to_food := nearest_food - position
		if to_food.length() > 1.0:
			direction = direction.lerp(to_food.normalized(), 0.06)
			movement = direction * speed * delta

	position += movement
	position.x = clampf(position.x, play_area.position.x, play_area.end.x)
	position.y = clampf(position.y, play_area.position.y, play_area.end.y)

	wander_timer -= delta
	if wander_timer <= 0.0:
		_pick_new_direction()

	var ate_food := false
	for food in food_positions:
		if position.distance_to(food) < 13.0:
			energy += 13.0
			ate_food = true
			break

	return {
		"ate_food": ate_food,
		"dead": energy <= 0.0 or age >= 150.0,
		"reproduce": energy >= 85.0
	}

func draw_ant() -> void:
	draw_circle(Vector2.ZERO, 5.0, Color(0.2, 0.15, 0.1))
	draw_circle(Vector2(4.0, 0), 3.8, Color(0.16, 0.12, 0.09))

func _draw() -> void:
	draw_ant()

func _pick_new_direction() -> void:
	direction = Vector2.from_angle(randf() * TAU)
	wander_timer = randf_range(0.8, 2.5)

func _nearest(points: Array[Vector2]) -> Vector2:
	var candidate := points[0]
	var best_distance := position.distance_squared_to(candidate)
	for p in points:
		var d := position.distance_squared_to(p)
		if d < best_distance:
			best_distance = d
			candidate = p
	return candidate
