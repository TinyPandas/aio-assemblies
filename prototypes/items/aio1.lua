local aioAssembler1 = table.deepcopy(data.raw["item"]["assembling-machine-1"])

aioAssembler1.name = "aio-assembly-1"
aioAssembler1.place_result = "aio-assembly-1"
aioAssembler1.icons = {
    {
        icon = aioAssembler1.icon,
        tint = {r=0.25,g=0.5,b=0.25,a=0.3}
    },
}

data:extend({aioAssembler1})