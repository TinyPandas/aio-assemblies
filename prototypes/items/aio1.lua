local aioAssembler1 = table.deepcopy(data.raw["item"]["assembling-machine-1"])

aioAssembler1.name = "aio-assembly-1"
aioAssembler1.place_result = "aio-assembly-1"
aioAssembler1.icons = {
    {
        icon = "__aio-assembler__/graphics/icons/aio-assembly-1.png"
    },
}

data:extend({aioAssembler1})