local tier_one_items = {
    ["iron-plate"] = true, ["copper-plate"] = true, ["steel-plate"] = true, ["coal"] = true,
    ["stone"] = true, ["wood"] = true
}

local function getBaseIngredients(ingredient, baseIngredients)
    baseIngredients = baseIngredients or {}
    local recipe_data = data.raw.recipe[ingredient]
    if recipe_data then
        local recipe = recipe_data["normal"] or recipe_data
        if recipe then
            local ingredients = recipe["ingredients"]

            for _, items in pairs(ingredients) do
                local item = items[1]
                local amount = items[2]

                if tier_one_items[item] then
                    baseIngredients[item] = amount + (baseIngredients[item] or 0) -- :D
                else
                    getBaseIngredients(item, baseIngredients)
                end
            end
        end
    end

    return baseIngredients
end

local function convertToBase(i_list)
    local final_ingredients = {}
    for _, items in pairs(i_list) do
        local item = items[1]
        local amount = items[2]

        if tier_one_items[item] then
            final_ingredients[item] = amount + (final_ingredients[item] or 0)
        else
            local base_items = getBaseIngredients(item)
            for i, j in pairs(base_items) do
                final_ingredients[i] = (j * amount) + (final_ingredients[i] or 0)
            end
        end
    end

    local list = {}
    for i, v in pairs(final_ingredients) do
        table.insert(list, {i, v})
    end
    return list
end

local enabled = true
local prereq
local effects
local recipe_list = {}
local recipes = {}

-- Get all recipes available from the start
for _, recipe_data in pairs(data.raw["recipe"]) do
    enabled = true
    for recipe_field in pairs(recipe_data) do
        if recipe_field == "enabled" then
            local state = recipe_data.enabled
            if state == "true" then
                enabled = true
            elseif state == "false" then
                enabled = false
            else
                enabled = state
            end
        end
    end
    if enabled then
        recipe_list[recipe_data.name] = true
    end
end

for p,k in pairs(data.raw["technology"]) do
    for a,b in pairs(k) do
        if a == "enabled" then
            if data.raw["technology"][p].enabled == "true" then
                enabled = true
            elseif data.raw["technology"][p].enabled == "false" then
                enabled = false
            else
                enabled = data.raw["technology"][p].enabled
            end
        end
    end
    prereq = false
    effects = false
    for a,b in pairs(k) do
        if a == "prerequisites" then
            if #b ~= 0 then
                prereq = true
            end
        elseif a == "effects" then
            effects = true
        end
        if prereq  and k.enabled ~= false then
            if effects then
                for _,j in pairs(data.raw["technology"][p].effects) do
                    if j.type =="unlock-recipe" then
                        recipe_list[j.recipe] = false
                    end
                end
            end
        elseif prereq == false  and k.enabled ~= false then
            if effects then
                for _,j in pairs(data.raw["technology"][p].effects) do
                    if j.type =="unlock-recipe" then
                        recipe_list[j.recipe] = true
                    end
                end
            end
        end
    end
end

for item, _ in pairs(recipe_list) do
    local recipe_data = data.raw.recipe[item]
    local recipe = recipe_data["normal"] or recipe_data

    local i_list = recipe["ingredients"]
    local res = recipe["result"]
    local resC = recipe["result_count"] or 1
    local eng = recipe["energy_required"] or 0.5
    local category = recipe["category"] or "crafting"
    local enabled = true
    if recipe["enabled"] ~= nil then
        enabled = recipe["enabled"]
    end

    if res then
        if category == "crafting" then
            table.insert(recipes, {
                type = "recipe",
                name = "aio-" .. item,
                category = "aio-crafting",
                energy_required = eng * 4,
                ingredients = convertToBase(i_list),
                hide_from_player_crafting = true,
                result = res,
                result_count = resC,
                enabled = enabled
            })
        end
    end
end

for _, recipe in pairs(recipes) do
    local name = recipe.name:sub(5)

    for _, technology in pairs(data.raw["technology"]) do
        local effects = technology["effects"]
        if effects then
            for _, effect in pairs(effects) do
                if effect["type"] == "unlock-recipe" and effect["recipe"] == name then
                    table.insert(effects, {
                        type = "unlock-recipe",
                        recipe = recipe.name
                    })
                end
            end
        end
    end
end

data:extend(recipes)