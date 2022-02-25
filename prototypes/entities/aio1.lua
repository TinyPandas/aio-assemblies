local aioAssembler1 = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-1"])

aioAssembler1.name = "aio-assembly-1"
aioAssembler1.minable = {mining_time = 0.8, result = "aio-assembly-1"}
--aioAssembler1.next_upgrade = "aio-assembly-2"
aioAssembler1.crafting_categories = {"aio-crafting"}
aioAssembler1.icons = {
    {
        icon = aioAssembler1.icon,
        tint = {r=0.25,g=0.5,b=0.25,a=0.3}
    },
}
aioAssembler1.crafting_speed = 0.8

data:extend({aioAssembler1})