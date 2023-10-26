
- add images to your "\rsg-inventory\html\images"

- add items to your "\rsg-core\shared\items.lua"
['ice'] 			        = {['name'] = 'ice', 		        ['label'] = 'Ice',                ['weight'] = 200, 		['type'] = 'item',				['image'] = 'ice.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0, 		['description'] = 'crafting material med´s'},

- add npc to your \rsg-npcs\config.lua
    -- icemining npc
    {    model = 'a_m_m_asbminer_01',     coords = vector4(-1752.93, 1687.66, 237.68, 38.76), },-- animation = 'WORLD_HUMAN_LEAN_POST_LEFT_HAND_PLANTED', -- Job: Shepherd
    {    model = 'a_m_m_asbminer_01',     coords = vector4(-1757.82, 1687.77, 238.15, 0.06), },-- animation = 'WORLD_HUMAN_LEAN_POST_LEFT_HAND_PLANTED', -- Job: Shepherd
    {    model = 'a_m_m_asbminer_01',     coords = vector4(-1761.12, 1688.38, 238.41, 290.01), },-- animation = 'WORLD_HUMAN_LEAN_POST_LEFT_HAND_PLANTED', -- Job: Shepherd
    {    model = 'a_m_m_asbminer_01',     coords = vector4(-1762.02, 1692.59, 238.46, 273.81), },-- animation = 'WORLD_HUMAN_LEAN_POST_LEFT_HAND_PLANTED', -- Job: Shepherd
    {    model = 'a_m_m_asbminer_01',     coords = vector4(-1754.11, 1694.48, 237.34, 140.28), },-- animation = 'WORLD_HUMAN_LEAN_POST_LEFT_HAND_PLANTED', -- Job: Shepherd
     
# Starting the resource
- add the following to your server.cfg file : ensure rsg-icemining

