local aioAssembler1 = table.deepcopy(data.raw["assembling-machine"]["assembling-machine-1"])

aioAssembler1.name = "aio-assembly-1"
aioAssembler1.minable = {mining_time = 0.5, result = "aio-assembly-1"}
aioAssembler1.crafting_categories = {"aio-crafting"}
aioAssembler1.animation = {
    filename = "__aio-assembler__/graphics/entity/aio-assembly-1.png",
    width = 108,
    height = 114,
    line_length = 8,
    frame_count = 32,
    animation_speed = 0.5
}
aioAssembler1.crafting_speed = 0.65

data:extend({aioAssembler1})