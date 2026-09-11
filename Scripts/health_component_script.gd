extends Node
class_name HealthComponent

signal health_changed(new_amount: int)
signal died

@export var max_health: int = 100
@export var healthBar: ProgressBar
@onready var current_health: float = max_health

func _ready() -> void:
	healthBar.value = max_health


func damage(attack: int) -> void:
	current_health = clamp(current_health - attack, 0, max_health)
	healthBar.value = current_health
	health_changed.emit(current_health)
	
	if current_health <= 0:
		died.emit()
