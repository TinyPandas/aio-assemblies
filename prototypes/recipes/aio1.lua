local recipe = table.deepcopy(data.raw.recipe["assembling-machine-1"])
recipe.enabled = true
recipe.name = "aio-assembly-1"
recipe.ingredients = {
    {"copper-plate", 200},
    {"iron-plate", 200},
    {"steel-plate", 50}
}
recipe.result = "aio-assembly-1"

data:extend({recipe})