extends Resource
class_name Artes

@export_subgroup("Main")
@export var ArteID : String
@export var ArteName : String
@export var ArtePotency : int
@export var ArteCost: int
@export var ArteSize: float
@export var ArteDuration: float
@export var ArteCastSpeed : float
@export var ArteCooldown: float
@export var ArteRepeat: int

@export_subgroup("Arte Weaving")
## What can the Arte Affect?
@export_enum("Self", "Target", "Area", "Ally", "Enemy") var ArteTarget
## What Shape does the Arte take?
@export_enum("Beam","Gataling", "Fan", "Orb", "Wall") var ArteForm
## How does the Arte Behave?
@export_flags("Accelerate", "React", "Bounce", "Seeking") var ArteTrait

@export_subgroup("Affinity")
@export_enum(
"Fire",
 "Ice",
 "Dark",
 "Lightning",
 "Earth",
 "Light",
 "Water",
"Wind",
"Space",
"Time",
"Destiny",
"Fate",
"Life",
"Death",
"Order",
"Chaos",
)  var ArteElement

@export_category("Effects")
@export var ArteChargeSound : Array[AudioStream]
@export var ArteCastSound : Array[AudioStream]
@export var ArteAmbientSound : Array[AudioStream]
@export var ArteFailedSound : Array[AudioStream]
