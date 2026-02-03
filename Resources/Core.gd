extends Resource
class_name Core

@export_category("Vitals")
@export var Health : float
@export var MaxHealth : int
@export var Mana : float
@export var MaxMana : int
@export var Stamina : float
@export var MaxStamina : int
@export var Hunger : float
@export var MaxHunger: int
@export_range(0, 100, 0.01) var Fatigue : float
@export_range(0, 100, 0.01) var MaxFatigue : float
@export_range(-50, 50, 0.01) var Temperature : float
@export_range(0, 100, 0.01) var Toxicity : float
@export_category("Resources")
@export var Currency : int
@export var InventorySlots : int
@export_range (-1000, 1000, 0.1) var Reputation : float
var CoreXP : Dictionary = {
	"MaxHealth" = 0,
	"MaxMana" = 0,
	"MaxStamina" = 0,
	"MaxFatigue" = 0
}
# Timed Resource Drains
var HealthDrain := 0.0
var ManaDrain := 0.0
var StaminaDrain := 1.0

#//-----------FUNCTIONS--------------------------------
func _health_impact(Amount: float) -> void:
	Health -= Amount

func _hunger_impact(Amount : float) -> void:
	Hunger -= Amount

# (Stat/MaxStat) * 100.0 | to get %
func _check_hunger():
	if Hunger >= MaxHunger:
		print("Well Fed")
	elif Hunger < MaxHunger and  (Hunger/MaxHunger) * 100 <= 10:
		print("Starving")
	elif Hunger < MaxHunger and (Hunger/MaxHunger) * 100 < 35:
		print("Hungry")
	elif Hunger < MaxHunger and (Hunger/MaxHunger) * 100 < 50:
		print("Normal")
	elif Hunger < MaxHunger and (Hunger/MaxHunger) * 100 < 90:
		print("Satisfied")

# Function to Check Fatigue Stages. Same Formula as Hunger.
func _check_fatigue():
	if Fatigue >= MaxFatigue:
		print("Well Rested") # Well Rested gives Bonuses
	elif Fatigue < MaxFatigue and  (Fatigue/MaxFatigue) * 100 <= 10:
		print("Exhausted") # Debilitating Debuff
	elif Fatigue < MaxFatigue and (Fatigue/MaxFatigue) * 100 < 35:
		print("Tired") #Notable Debuff
	elif Fatigue < MaxFatigue and (Fatigue/MaxFatigue) * 100 < 70:
		print("Normal")
