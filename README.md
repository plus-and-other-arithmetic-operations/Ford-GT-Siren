# Ford-GT-Siren

Pro-bono project made for Axis' Ford GT police cruiser mod.

## Setup

Add the siren folder into the car's extension folder.

After adding the banks into the car, you need to add the `[SCRIPT_...]` entry to your car's ext_config

```ini
[SCRIPT_...]
SCRIPT = siren.lua

```

Finally, add emmissive entries for the 3 different siren modes:

```ini
[EMISSIVE_...]
INPUT=HORN
NAME=INT_COP_AIRHORN
COLOR=3,1,1,2
OFF_COLOR=3,1,1,1

[EMISSIVE_...]
INPUT=EXTRA_E
NAME=INT_COP_WAIL
COLOR=3,1,1,2
OFF_COLOR=3,1,1,1

[EMISSIVE_...]
INPUT=EXTRA_F
NAME=INT_COP_YELP
COLOR=3,1,1,2
OFF_COLOR=3,1,1,1
```
