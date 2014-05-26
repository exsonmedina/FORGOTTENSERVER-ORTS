local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local function creatureSayCallback(cid, type, msg)
	local player = Player(cid)
	if not npcHandler:isFocused(cid) then
		return false
	elseif(msgcontains(msg, "farmine")) then
		if(player:getStorageValue(1015) == 15) then
			npcHandler:say("I have heard only little about this mine. I am a bit absorbed in my studies. But what does this mine have to do with me?", cid)
			npcHandler.topic[cid] = 1
		end
	elseif(msgcontains(msg, "reason")) then
		if(npcHandler.topic[cid] == 1) then
			if(player:getStorageValue(1025) < 1) then
				npcHandler:say("Well it sounds like a good idea to test my golems in some real environment. I think it is acceptable to send some of them to Farmine.", cid)
				player:setStorageValue(1025, 1)
				player:setStorageValue(12135, player:getStorageValue(12135) + 1) --Questlog, The New Frontier Quest "Mission 05: Getting Things Busy"
			end
		end
	end
	return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
