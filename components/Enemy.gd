extends Node2D

export var health: int = 100
export var max_health: int = 100

signal clicked
signal spawned

func _ready():
  $HealthBar.update_health(health, max_health)
  add_to_group("enemies")
  print("Spawn enemy")
  var original_position = position
  var spawn_position = original_position - Vector2(0, 100)
  position = spawn_position
  
  $DropInTween.interpolate_property(self, "position", spawn_position, original_position, 0.5, Tween.EASE_IN, Tween.EASE_IN)
  $DropInTween.start()
  yield($DropInTween, "tween_completed")
  print("Spawned")
  emit_signal("spawned")

func deal_damage(damage: int) -> bool:
  print("Got hit")
  var original_position = position
  var damage_position = original_position - Vector2(0, 10)
  
  $HitTween.interpolate_property(self, "position", position, damage_position, 0.1, Tween.EASE_IN, Tween.EASE_IN)
  $HitTween.start()
  yield($HitTween, "tween_completed")
  
  health -= damage
  if health <= 0:
    health = 0
  $HealthBar.update_health(health, max_health)
  
  $HitTween.interpolate_property(self, "position", position, original_position, 0.1, Tween.EASE_IN, Tween.EASE_IN)
  $HitTween.start()
  yield($HitTween, "tween_completed")
  
  if health == 0:
    return true
    
  return false

func select():
  pass

func deselect():
  pass

func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
  if event.is_pressed():
    emit_signal("clicked")

