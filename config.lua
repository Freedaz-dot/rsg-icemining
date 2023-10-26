Config = {}

Config.Debug = false

--[[ Config.DeliveryBlip = {
    blipName = 'Delivery Ice Job', -- Config.Blip.blipName
    blipSprite = 'blip_ambient_delivery', -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
} ]]

Config.IceBlip = {
    blipName = 'Ice', -- Config.Blip.blipName
    blipSprite = 'blip_ambient_delivery', -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

Config.KeyBindIceMining = 'SPACEBAR'
Config.KeyBindIce = 'J'
Config.KeyBindIceDelivery = 'E'

Config.IceMiningRewards = {
    'rock',
    'ice'
}


-- set item rewards amount
Config.SmallIceRewardAmount = 1
Config.LargeIceRewardAmount = 2

-- set item rewards amount
Config.PriceIce = 1
Config.SellTime = 5000

Config.IceLocations = {
    {name = 'Lake Isabella',      location = 'lake-isabella',      coords = vector3(-1764.46, 1695.09, 238.61),        showblip = true}, --st denis
}

-- delivery locations
Config.DeliveryIceLocations = {
    {   -- saint denis -> valentine ( distance 3794 / $37.94)
        name        = 'Valentine',
        deliveryid  = 'deliveryice1',
        cartspawn   = vector3(-1731.34, 1756.23, 235.9),
        cartspawnW   = 52.44,
        cart        = 'wagon05x',
        cargo       = 'pg_teamster_wagon05x_gen',
        light       = 'pg_teamster_wagon05x_lightupgrade3',
        startcoords = vector3(-1764.46, 1695.09, 238.61),
        endcoords   = vector3(-345.82, 765.77, 116.19),
        missionicetime = math.random(20, 30), -- in mins
        showgps     = true,
    },
    {   -- valentine -> blackwater ( distance 2200 / $22.00)
        name        = 'Blackwater',
        deliveryid  = 'deliveryice2',
        cartspawn   = vector3(-1789.62, 1702.2, 239.04),
        cartspawnW   = 187.6,
        cart        = 'wagon05x',
        cargo       = 'pg_teamster_wagon05x_gen',
        light       = 'pg_teamster_wagon05x_lightupgrade3',
        startcoords = vector3(-1764.46, 1695.09, 238.61),
        endcoords   = vector3(-739.7944, -1354.417, 43.461048),
        missionicetime = math.random(20, 30), -- in mins
        showgps     = true,
    },
    {   -- blackwater -> strawberry ( distance 1303 / $13.03)
        name        = 'Strawberry',
        deliveryid  = 'deliveryice3',
        cartspawn   = vector3(-1789.62, 1702.2, 239.04),
        cartspawnW   = 187.6,
        cart        = 'wagon05x',
        cargo       = 'pg_teamster_wagon05x_gen',
        light       = 'pg_teamster_wagon05x_lightupgrade3',
        startcoords = vector3(-1764.46, 1695.09, 238.61),
        endcoords   = vector3(-1792.688, -434.3452, 155.59338),
        missionicetime = math.random(20, 30), -- in mins
        showgps     = true,
    },
    {   -- strawberry -> mcfarlands ranch ( distance 2033 / $20.33)
        name        = 'Ranch',
        deliveryid  = 'deliveryice4',
        cartspawn   = vector3(-1810.85, 1635.44, 240.86),
        cartspawnW   = 203.43,
        cart        = 'wagon05x',
        cargo       = 'pg_teamster_wagon05x_gen',
        light       = 'pg_teamster_wagon05x_lightupgrade3',
        startcoords = vector3(-1764.46, 1695.09, 238.61),
        endcoords   = vector3(-2381.418, -2384.764, 61.069843),
        missionicetime = math.random(20, 30), -- in mins
        showgps     = true,
    },
    {   -- mcfarlands ranch -> tumbleweed  ( distance 3214 / $32.14)
        name        = 'Tumbleweed',
        deliveryid  = 'deliveryice5',
        cartspawn   = vector3(-1731.34, 1756.23, 235.9),
        cartspawnW   = 52.44,
        cart        = 'wagon05x',
        cargo       = 'pg_teamster_wagon05x_gen',
        light       = 'pg_teamster_wagon05x_lightupgrade3',
        startcoords = vector3(-1764.46, 1695.09, 238.61),
        endcoords   = vector3(-5521.942, -2938.532, -1.995861),
        missionicetime = math.random(25, 30), -- in mins
        showgps     = true,
    },
}

-- mining locations
Config.IceMiningLocations = {
    {name = 'Ice mining Mount',	location = 'icemining1', coords = vector3(-1883.06, 1841.95, 237.75),	    showblip = true, showmarker = false},
    {name = 'Ice mining',	location = 'icemining2', coords = vector3(-1880.13, 1844.5, 239.16),		    showblip = false, showmarker = false},
    {name = 'Ice mining',	location = 'icemining3', coords = vector3(-1888.93, 1844.86, 236.1),			showblip = false, showmarker = false},
	{name = 'Ice mining',	location = 'icemining4', coords = vector3(-1889.31, 1841.43, 235.7),			showblip = false, showmarker = false},
	{name = 'Ice mining',	location = 'icemining5', coords = vector3(-1886.86, 1846.02, 237.06),			showblip = false, showmarker = false},
    {name = 'Ice mining',	location = 'icemining6', coords = vector3(-1903.09, 1843.52, 235.58),			showblip = false, showmarker = false},
    {name = 'Ice mining',	location = 'icemining7', coords = vector3(-1904.41, 1846.31, 235.62),			showblip = false, showmarker = false},
	{name = 'Ice mining',	location = 'icemining8', coords = vector3(-1920.86, 1854.12, 235.5),			showblip = false, showmarker = false},
	{name = 'Ice mining',	location = 'icemining9', coords = vector3(-1926.8, 1853.99, 235.94),			showblip = false, showmarker = false},
    {name = 'Ice mining',	location = 'icemining10', coords = vector3(-1926.2, 1849.09, 235.25),			showblip = false, showmarker = false},
    {name = 'Ice mining',	location = 'icemining11', coords = vector3(-1929.01, 1841.77, 236.1),			showblip = false, showmarker = false},
	{name = 'Ice mining',	location = 'icemining12', coords = vector3(-1932.12, 1806.86, 235.64),			showblip = false, showmarker = false},
	{name = 'Ice mining',	location = 'icemining13', coords = vector3(-1933.71, 1803.68, 235.63),			showblip = false, showmarker = false},
    {name = 'Ice mining',	location = 'icemining14', coords = vector3(-1958.45, 1794.18, 235.3),			showblip = false, showmarker = false},
    {name = 'Ice mining',	location = 'icemining15', coords = vector3(-1962.15, 1797.11, 235.13),			showblip = false, showmarker = false},
	{name = 'Ice mining',	location = 'icemining16', coords = vector3(-1967.46, 1804.82, 236.14),			showblip = false, showmarker = false},
	{name = 'Ice mining',	location = 'icemining17', coords = vector3(-1968.68, 1809.64, 237.07),			showblip = false, showmarker = false},
    {name = 'Ice mining',	location = 'icemining18', coords = vector3(-1982.21, 1806.49, 236.48),			showblip = false, showmarker = false},
	{name = 'Ice mining',	location = 'icemining19', coords = vector3(-1972.82, 1774.82, 236.36),			showblip = false, showmarker = false},
	{name = 'Ice mining',	location = 'icemining20', coords = vector3(-1972.75, 1770.77, 236.3),			showblip = false, showmarker = false},
    {name = 'Ice mining',	location = 'icemining21', coords = vector3(-1964.13, 1760.27, 235.36),			showblip = false, showmarker = false},
    {name = 'Ice mining',	location = 'icemining22', coords = vector3(-1963.19, 1760.8, 235.35),			showblip = false, showmarker = false},
	{name = 'Ice mining',	location = 'icemining23', coords = vector3(-1962.57, 1765.26, 235.25),			showblip = false, showmarker = false},
	{name = 'Ice mining',	location = 'icemining24', coords = vector3(-1945.77, 1757.34, 235.18),			showblip = false, showmarker = false},
    {name = 'Ice mining',	location = 'icemining25', coords = vector3(-1939.86, 1758.99, 235.51),			showblip = false, showmarker = false},
    {name = 'Ice mining',	location = 'icemining26', coords = vector3(-1901.5, 1765.96, 235.41),			showblip = false, showmarker = false},
	{name = 'Ice mining',	location = 'icemining27', coords = vector3(-1884.0, 1760.25, 235.67),			showblip = false, showmarker = false},
	{name = 'Ice mining Mount',	location = 'icemining28', coords = vector3(-1856.88, 1734.44, 236.41),		showblip = false, showmarker = false},
}
  