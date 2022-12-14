extends Node2D
class_name HealthBar

export var entity_path: NodePath

onready var background_rect = $Background
onready var health_rect = $Health
onready var shield_rect = $Shield

var entity: Entity


func _ready() -> void:
	entity = get_node(entity_path)

func _physics_process(_delta: float) -> void:
	var max_total = entity.max_health + entity.max_shield
	var max_width = background_rect.rect_size.x

	var health_width = entity.health * max_width / max_total
	var shield_width = entity.shield * max_width / max_total

	health_rect.rect_size.x = health_width
	shield_rect.rect_position.x = health_width
	shield_rect.rect_size.x = shield_width
