local sirenPos = vec3(0, 1.2, 0)

local sirenModes = {
	normalSiren = 0.3,
	pursuitSiren = 0.6,
	yelpSiren = 0.9,
	off = nil,
}

local volumes= {
	siren = 1.5,
	horn = 1,
}

local currentSirenMode = sirenModes.off

ac.loadSoundbank("siren/siren.bank", "siren/GUIDs.txt")
local sirenEvent = ac.AudioEvent("cars/siren/siren", true)
sirenEvent.volume = ac.getAudioVolume('main') * volumes.siren
sirenEvent:setPosition(sirenPos)

-- THIS IS SCUFFED
-- There doesn't seem to be a proper way to directly 
-- manipulate the already loaded soundbank by the game, 
-- so I copied the car's soundbank loaded it only to 
-- access the horn audio event.

-- Suggestion: add a horn sound event into the siren.bank. 
-- That way i'll only need to load 1 soundbank, and I can
-- access both events at the same time :)
ac.loadSoundbank("horn/axis_ford_gt_cop.bank", "horn/GUIDs.txt") 
local hornEvent = ac.AudioEvent("cars/axis_ford_gt_cop/horn", true)
hornEvent.volume = ac.getAudioVolume('main') * volumes.horn
hornEvent:setPosition(sirenPos)

function switchMode()
	if (car.extraD) then
		currentSirenMode = sirenModes.off
		hornEvent.volume = 0 -- disable horn when sirens are on
		if (car.extraE) then -- extraE requires extraD
			if (car.extraF) then --extraF requires extraE
				ac.log("Pressed: E/F - Pursuit Mode" )
				currentSirenMode = sirenModes.pursuitSiren
			else
				ac.log("Pressed: E - Normal Mode" )
				currentSirenMode = sirenModes.normalSiren
			end
		end
		if (car.hornActive) then
			ac.log("Pressed: Horn - Yelp Mode" )
			currentSirenMode = sirenModes.yelpSiren
		end
	else
		currentSirenMode = sirenModes.off
		hornEvent.volume = 1
	end
end

function script.update(dt)
	sirenEvent:resumeIf(car.extraD and (car.extraE or car.extraF or car.hornActive) and currentSirenMode ~= sirenModes.off)
	hornEvent:resumeIf(car.hornActive)
	switchMode()
	sirenEvent:setParam("state", currentSirenMode)
end
