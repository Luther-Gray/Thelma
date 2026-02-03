extends Resource
class_name Weapons
# Weapons are tools constructed for the purpose of battle. Whether on a large scale or small scale weapons have existed on Thelma almost as long as sentient life has existed.
## Level Requirements are soft. Meaning that technically, anyone can wield anything. However their ability to use a weapon to its fullest is closely tied to the weapons's Level Requirement.
@export_range(1, 100) var LevelRequirements : int
@export_enum("Sword", "Mace", "Spear", "Whip", "Gauntlets", "Grand Sword", "Foci", "Disks", "Dagger", "Bow") var WeaponType : String
## Weapon Classes determine that weapon's Purpose. Earth Class is for Killing. Beast Class is for Slaying. Sky Class is for Purging.
@export_enum("Earth Class", "Beast Class", "Sky Class") var WeaponClass : String
@export var WeaponLore : String
@export var isTwoHanded : bool
@export var WeaponDamage : String
@export var WeaponDurability : float
