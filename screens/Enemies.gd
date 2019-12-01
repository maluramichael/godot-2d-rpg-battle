extends Node

signal enemy_selection_changed

var selected_enemy = null

func _ready():
  for i in range(3):
    var enemy = create_enemy()
    yield(enemy, "spawned")
    

func create_enemy():
  var spawn_points = get_tree().get_nodes_in_group("spawn_points")
  var empty_spawn_point
  for spawn_point in spawn_points:
    if not spawn_point.occupied:
      empty_spawn_point = spawn_point
      break
  if empty_spawn_point:
    empty_spawn_point.occupied = true
    var enemy = load("res://components/Enemy.tscn")
    var instance = enemy.instance()
    instance.set_position(empty_spawn_point.position)
    instance.connect("clicked", self, "enemy_clicked", [instance])
    add_child(instance)
    return instance

func enemy_clicked(enemy):
  print("Enemy clicked", enemy)

  if is_instance_valid(selected_enemy):
    selected_enemy.deselect()

  selected_enemy = enemy
  selected_enemy.select()

  emit_signal("enemy_selection_changed", selected_enemy)
