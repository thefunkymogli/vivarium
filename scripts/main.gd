extends Node2D

const AntScene := preload("res://scripts/ant.gd")

@onready var world := $World
@onready var overlay := $CanvasLayer/Panel/VBoxContainer
@onready var ants_label: Label = $CanvasLayer/Panel/VBoxContainer/Ants
@onready var food_label: Label = $CanvasLayer/Panel/VBoxContainer/Food
@onready var waste_label: Label = $CanvasLayer/Panel/VBoxContainer/Waste
@onready var nutrients_label: Label = $CanvasLayer/Panel/VBoxContainer/Nutrients
@onready var tip_label: Label = $CanvasLayer/Panel/VBoxContainer/Tip

var play_area := Rect2(Vector2(60, 60), Vector2(1160, 600))
var ants: Array[Ant] = []
var food_nodes: Array[Node2D] = []

var waste: float = 0.0
var nutrients: float = 14.0
var spawn_cooldown: float = 0.0

func _ready() -> void:
	randomize()
	for i in 8:
		_spawn_ant(play_area.get_center() + Vector2(randf_range(-40, 40), randf_range(-40, 40)))
	for i in 18:
		_spawn_food(_random_food_pos())
	_update_ui()

func _process(delta: float) -> void:
	_tick_environment(delta)
	_tick_ants(delta)
	_update_ui()
	queue_redraw()

func _tick_environment(delta: float) -> void:
	nutrients += waste * 0.04 * delta
	waste = maxf(0.0, waste - delta * 0.35)

	spawn_cooldown -= delta
	if spawn_cooldown <= 0.0 and nutrients >= 2.0 and food_nodes.size() < 50:
		_spawn_food(_random_food_pos())
		nutrients -= 2.0
		spawn_cooldown = randf_range(0.25, 0.7)

func _tick_ants(delta: float) -> void:
	var food_positions: Array[Vector2] = []
	for f in food_nodes:
		food_positions.append(f.position)

	var dead_ants: Array[Ant] = []
	var newborn_positions: Array[Vector2] = []

	for ant in ants:
		var result := ant.tick(delta, food_positions, play_area)

		if result.ate_food:
			_consume_food_near(ant.position)
			waste += 1.2

		if result.reproduce and ants.size() + newborn_positions.size() < 45:
			ant.energy *= 0.53
			newborn_positions.append(ant.position + Vector2(randf_range(-8, 8), randf_range(-8, 8)))

		if result.dead:
			dead_ants.append(ant)
			nutrients += 1.8

	for ant in dead_ants:
		ants.erase(ant)
		ant.queue_free()

	for pos in newborn_positions:
		_spawn_ant(pos)

func _consume_food_near(pos: Vector2) -> void:
	for food in food_nodes:
		if pos.distance_to(food.position) < 14.0:
			food_nodes.erase(food)
			food.queue_free()
			return

func _spawn_ant(pos: Vector2) -> void:
	var ant := AntScene.new() as Ant
	ant.position = pos
	world.add_child(ant)
	ants.append(ant)

func _spawn_food(pos: Vector2) -> void:
	var marker := Node2D.new()
	marker.position = pos
	marker.set_script(preload("res://scripts/food.gd"))
	world.add_child(marker)
	food_nodes.append(marker)

func _random_food_pos() -> Vector2:
	return Vector2(
		randf_range(play_area.position.x + 12.0, play_area.end.x - 12.0),
		randf_range(play_area.position.y + 12.0, play_area.end.y - 12.0)
	)

func _update_ui() -> void:
	ants_label.text = "Ants: %d" % ants.size()
	food_label.text = "Food: %d" % food_nodes.size()
	waste_label.text = "Waste: %.1f" % waste
	nutrients_label.text = "Nutrients: %.1f" % nutrients
	tip_label.text = "Space: add food | Backspace: remove 3 ants | R: reset"

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		_spawn_food(_random_food_pos())
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_SPACE:
			for i in 4:
				_spawn_food(_random_food_pos())
		elif event.keycode == KEY_BACKSPACE:
			_remove_ants(3)
		elif event.keycode == KEY_R:
			_reset_world()

func _remove_ants(count: int) -> void:
	for i in min(count, ants.size()):
		var ant := ants.pop_back()
		ant.queue_free()
		nutrients += 0.5

func _reset_world() -> void:
	for ant in ants:
		ant.queue_free()
	ants.clear()
	for food in food_nodes:
		food.queue_free()
	food_nodes.clear()
	waste = 0.0
	nutrients = 14.0
	for i in 8:
		_spawn_ant(play_area.get_center() + Vector2(randf_range(-40, 40), randf_range(-40, 40)))
	for i in 18:
		_spawn_food(_random_food_pos())

func _draw() -> void:
	draw_rect(play_area, Color(0.15, 0.19, 0.15), false, 2.0)
