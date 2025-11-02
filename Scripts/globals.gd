extends Node

var player_pos: Vector2 = Vector2(1075, 837)
var global_player_pos: Vector2
var player_damage: int = 10
var player_speed: int = 460
var player_shoot_speed: float = 0.3
var dakimakura_count: int = 0

var number_of_enemies: int 
var enemy_pos: Vector2
var global_enemy_pos: Vector2
var current_wave: int

var dakimakura_price: int = 4
var estrogenator_price: int = 24
var kabachok_price: int = 20
var energy_drink_price: int = 40

var money: int = 0
