extends Node2D

onready var player = $Player
var selected_enemy = null

func get_random_enemy():
  var enemies = get_tree().get_nodes_in_group("enemies")
  var index = floor(rand_range(0, enemies.size()))
  return enemies[index]

func _on_AttackButton_pressed() -> void:
  var enemy
  if selected_enemy != null:
    enemy = selected_enemy
  else:
   enemy = get_random_enemy()
  
  if enemy:
    player.attack(enemy)
    yield(player, "attacked")
    if enemy.health <= 0:
      selected_enemy = null
      enemy.free()

func _on_DefendButton_pressed() -> void:
  pass # Replace with function body.

func _on_HealButton_pressed() -> void:
  pass # Replace with function body.

func _on_enemy_selection_changed(enemy) -> void:
  selected_enemy = enemy
