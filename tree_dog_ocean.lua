-- Waste Management and Recycling Consultancy --

-- Global Variables --
local wasteTypes = {"Solid", "Liquid", "Organic", "Hazardous"}
local recyclables = {"Metal", "Plastic", "Paper", "Glass"}
local wasteCollectionServices = {"Curbside", "Centralized", "Drop Off"}

-- Utility Functions --
local function calculateTotalWeight(type, weight)
	if type == "Solid" then
		return weight * 1.2
	elseif type == "Liquid" then
		return weight * 1.5
	elseif type == "Organic" then
		return weight * 2
	elseif type == "Hazardous" then
		return weight * 2.5
	else
		return 0
	end
end

local function calculateRecycledWeight(recyclables, weight)
	local recycledWeight = 0
	for recyclable in ipairs( recyclables ) do
		if recyclable == "Metal" then
			recycledWeight = recycledWeight + (weight * 1.3)
		elseif recyclable == "Plastic" then
			recycledWeight = recycledWeight + (weight * 1.2)
		elseif recyclable == "Paper" then
			recycledWeight = recycledWeight + (weight * 1.1)
		elseif recyclable == "Glass" then
			recycledWeight = recycledWeight + (weight * 1)
		else
			return 0
		end
	end

	return recycledWeight
end

-- Core Business Logic --
function processWaste(type, weight, recyclables)
	local totalWeight = calculateTotalWeight(type, weight)
	local recycledWeight = calculateRecycledWeight(recyclables, weight)
	local wasteWeight = totalWeight - recycledWeight

	return {
		totalWeight = totalWeight,
		recycledWeight = recycledWeight,
		wasteWeight = wasteWeight
	}
end

function offerWasteCollectionServices(locations, wasteTypes, wasteCollectionServices)
	local services = {}
	for _, location in ipairs(locations) do
		local offeredServices = {}
		for _, wasteType in ipairs(wasteTypes) do
			for _, service in ipairs(wasteCollectionServices) do
				table.insert(offeredServices, {
					location = location,
					wasteType = wasteType,
					service = service
				})
			end
		end
		if #offeredServices > 0 then
			services[location] = offeredServices
		end
	end

	return services
end

-- Main --
local locations = {"North", "South", "East", "West"}
local wasteCollectionServices = offerWasteCollectionServices(locations, wasteTypes, wasteCollectionServices)

local report = {}
for location, services in pairs(wasteCollectionServices) do
	report[location] = {}
	for _, service in ipairs(services) do
		table.insert(report[location], string.format('%s %s waste collection', service.service, service.wasteType))
	end
end

for location, services in pairs(report) do
	print(string.format('Waste collection services offered in %s:', location))
	for _, service in ipairs(services) do
		print(service)
	end
end