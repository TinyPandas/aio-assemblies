local aioFrame = table.deepcopy(data.raw["item"]["iron-plate"])

aioFrame.name = "aio-frame"
aioFrame.place_result = ""
aioFrame.icons = {
    {
        icon = "__aio-assembler__/graphics/icons/aio-frame.png"
    },
}
aioFrame.stack_size = 4

data:extend({aioFrame})