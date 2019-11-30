extends Node2D

export var health: int = 100
export var max_health: int = 100

signal clicked

func deal_damage(damage: int):
  health -= damage
  if health <= 0:
    health = 0
  $HealthBar.update_health(health, max_health)

  if health == 0:
    queue_free()

func select():
  pass

func deselect():
  pass

func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
  if event.is_pressed():
    emit_signal("clicked")

