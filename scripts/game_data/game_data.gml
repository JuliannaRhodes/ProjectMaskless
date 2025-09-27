// party data
 global.party = 
 [
	{
		name: "PC1",
		hp: 50,
		hpmax: 50,
		mp: 10,
		mpMax: 15,
		strength: 6,
		sprites: { },
		actions: []
	}
];

// enemy data
global.enemies =
{
	npc1:
	{
		name: "NPC1",
		hp: 50,
		hpmax: 50,
		mp: 0,
		mpMax: 0,
		strength: 6,
		sprites: { idle: spr_npc_battle},
		actions: [],
		xpValue: 15,
		AIscript: function()
		{
			//enemy turn ai goes here
		}
	}
}