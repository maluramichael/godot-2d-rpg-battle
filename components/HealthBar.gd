extends Node2D

func update_health(current_health: float, max_health: float):
  var bar = $Bar
  var health_fac = 1.0 - (current_health / max_health)
  bar.frame = floor(lerp(0, bar.vframes - 1, health_fac))
