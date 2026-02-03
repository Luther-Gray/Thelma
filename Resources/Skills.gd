extends Resource
class_name Skills

@export var LearnedSkills : Dictionary = {}

## Boosts effectiveness of potions and pills consumed while also slightly reducing toxicity.
@export_range(0, 100) var AlchemicalVeins : int
## Increase damage when wielding two weapons or two spells simultaneously.
@export_range(0, 100) var Ambidextrous : int
## Resist Cold Temperatures and Cold Damage.
@export_range(0, 100) var ColdResistance : int
## Food you cook have increased benefits.
@export_range(0, 100) var Cooking : int
@export_range(0, 100) var FearResistance : int
@export_range(0, 100) var HeatResistance : int
@export_range(0, 100) var HeavyArmor : int
## Allows one to identify accurately the world around them.
@export_range(0, 100) var Inspect : int
@export_range(0, 100) var IronStomach : int
@export_range(0, 100) var IronWill : int
@export_range(0, 100) var Language : int
@export_range(0, 100) var Leadership : int
@export_range(0, 100) var Learning : int
@export_range(0, 100) var LightArmor : int
@export_range(0, 100) var Lockpick : int
@export_range(0, 100) var Lore : int
@export_range(0, 100) var MagicResistance : int
@export_range(0, 100) var MediumArmor : int
@export_range(0, 100) var Mercantile : int
@export_range(0, 100) var Nimble : int
@export_range(0, 100) var Pickpocket : int
## The ability to steer and operate Air Ships
@export_range(0, 100) var Piloting : int
@export_range(0, 100) var PoisonResistance : int
@export_range(0, 100) var Regeneration : int
@export_range(0, 100) var SixthSense : int
@export_range(0, 100) var Slayer : int
@export_range(0, 100) var Survivalist : int
@export_range(0, 100) var Unarmored : int
