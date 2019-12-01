extends Node2D

signal move_finished
signal attacked

export var health: int = 100
export var max_health: int = 100
export var speed: float = 100

onready var tween: Tween = $Tween

var is_attacking = false

func _ready():
  $HealthBar.update_health(health, max_health)

func attack(enemy):
  if is_attacking: return
  
  is_attacking = true
  print("Attack")
  var original_player_position = position

  move_to(enemy.position)
  yield(self, "move_finished")

  var is_dead = enemy.deal_damage(10)

  move_to(original_player_position)
  yield(self, "move_finished")

  is_attacking = false
  
  emit_signal("attacked", is_dead)
  
  return is_dead
  
func move_to(destination):
  print("Move to", destination)
  var duration = position.distance_to(destination) / speed
  tween.interpolate_property(self, "position", position, destination, duration, Tween.EASE_OUT, Tween.EASE_IN)
  tween.start()
  yield(tween, "tween_completed")
  emit_signal("move_finished")
