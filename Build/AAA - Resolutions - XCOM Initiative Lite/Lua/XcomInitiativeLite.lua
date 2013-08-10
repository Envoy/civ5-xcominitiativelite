-- XcomInitiativeLite
-- Author: Envoy (@fourfourhero)
-- DateCreated: 8/10/2013 4:19:32 PM
--------------------------------------------------------------

-- player must have xomc headquarters wonder to train xcom squad unit
function CanTrainXcomSquad(iPlayer, unitTypeID)
	--print("--CanTrainXcomSquad");
	local player = Players[iPlayer];
	local unitType = GameInfo.Units[unitTypeID].Type;
		
	if unitType == "UNIT_XCOM_SQUAD" then
		local xcomHqId = GameInfo.BuildingClasses["BUILDINGCLASS_XCOM_HEADQUARTERS"].ID;
		
		local buildingCount = player:GetBuildingClassCount(xcomHqId);
		if buildingCount > 0 then
			return true;
		end
		return false;
	end		

	return true;
end
--GameEvents.PlayerCanTrain.Add(CanTrainXcomSquad);

function CityCanTrainXcomSquad(iPlayer, iCity, unitTypeID)
	print("--CityCanTrainXcomSquad");
	local player = Players[iPlayer];
	local city = player:GetCityByID(iCity);
	local unitType = GameInfo.Units[unitTypeID].Type;	
	
	if unitType == "UNIT_XCOM_SQUAD" then	
		local xcomGarrisonId = GameInfo.Buildings["BUILDING_XCOM_GARRISON"].ID;
		local xcomOutpostId = GameInfo.Buildings["BUILDING_XCOM_OUTPOST"].ID;
		
		-- hq enables all cities to build
		local xcomHqId = GameInfo.BuildingClasses["BUILDINGCLASS_XCOM_HEADQUARTERS"].ID;		
		local hasHq = player:GetBuildingClassCount(xcomHqId) > 0;
		
		local buildingCount = city:GetNumBuilding(xcomGarrisonId);
		buildingCount = buildingCount + city:GetNumBuilding(xcomOutpostId);		
		
		if hasHq or buildingCount > 0 then
			return true;
		end
		return false;
	end		

	return true;
end
GameEvents.CityCanTrain.Add(CityCanTrainXcomSquad);

print("XcomInitiativeLite.lua loaded.");