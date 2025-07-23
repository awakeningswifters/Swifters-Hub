local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Swifters Hub",
    Icon = 0,
    LoadingTitle = "Swifters Hub",
    LoadingSubtitle = "by Awakening",
    Theme = "Default",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "Big Hub"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = false
})

Rayfield:Notify({
    Title = "Swift Hub Executed!",
    Content = "By: Awakening",
    Duration = 3,
    Image = 4483362458,
})

-- Shared Variables
local AutoPlant, AutoCollect, AutoDestroy, AutoBuy = false, false, false, false
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local function PlantSeeds()
    while AutoPlant and task.wait(2) do
        for _, plot in pairs(workspace.Plots:GetChildren()) do
            if plot:IsA("Part") and plot:FindFirstChild("Empty") then
                print("Planting at plot:", plot.Name)
                -- Replace this with actual planting logic
                game:GetService("ReplicatedStorage").RemoteEvents.PlantSeed:FireServer(_G.SelectedSeedToBuy or "Carrot Seed", plot)
            end
        end
    end
end

local function CollectFruits()
    while AutoCollect and task.wait(1) do
        for _, crop in pairs(workspace.Crops:GetChildren()) do
            if crop:FindFirstChild("ReadyToHarvest") then
                print("Collecting fruit:", crop.Name)
                game:GetService("ReplicatedStorage").RemoteEvents.Harvest:FireServer(crop)
            end
        end
    end
end

local function DestroyGrownPlants()
    while AutoDestroy and task.wait(3) do
        for _, plant in pairs(workspace.Crops:GetChildren()) do
            if plant:FindFirstChild("Harvested") then
                print("Destroying plant:", plant.Name)
                game:GetService("ReplicatedStorage").RemoteEvents.RemoveCrop:FireServer(plant)
            end
        end
    end
end

local function AutoBuySeeds()
    while AutoBuy and task.wait(5) do
        local seed = _G.SelectedSeedToBuy or "Carrot Seed"
        local amount = _G.AmountToBuy or 1
        print("Buying", amount, seed)
        game:GetService("ReplicatedStorage").RemoteEvents.BuySeed:FireServer(seed, amount)
    end
end

-- UI
local AutoFarmTab = Window:CreateTab("Auto Farm", 0)
AutoFarmTab:CreateSection("Auto Plant")

AutoFarmTab:CreateToggle({
    Name = "Auto Plant Seeds",
    CurrentValue = false,
    Flag = "AutoPlantToggle",
    Callback = function(Value)
        AutoPlant = Value
        if Value then task.spawn(PlantSeeds) end
    end,
})

AutoFarmTab:CreateToggle({
    Name = "Auto Collect Fruits",
    CurrentValue = false,
    Flag = "AutoCollectToggle",
    Callback = function(Value)
        AutoCollect = Value
        if Value then task.spawn(CollectFruits) end
    end,
})

AutoFarmTab:CreateToggle({
    Name = "Auto Destroy Grown Plants",
    CurrentValue = false,
    Flag = "AutoDestroyToggle",
    Callback = function(Value)
        AutoDestroy = Value
        if Value then task.spawn(DestroyGrownPlants) end
    end,
})

AutoFarmTab:CreateSection("Auto Buy Seeds")

AutoFarmTab:CreateToggle({
    Name = "Auto Buy Seeds (if in stock!)",
    CurrentValue = false,
    Flag = "AutoBuyToggle",
    Callback = function(Value)
        AutoBuy = Value
        if Value then task.spawn(AutoBuySeeds) end
    end,
})

AutoFarmTab:CreateDropdown({
    Name = "Select Seeds To Auto Buy",
    Options = {
        "Carrot Seed", "Strawberry Seed", "Blueberry Seed", "Orange Tulip Seed", "Tomato Seed",
        "Corn Seed", "Daffodil Seed", "Watermelon Seed", "Pumpkin Seed", "Apple Seed", "Bamboo Seed",
        "Coconut Seed", "Cactus Seed", "Dragon Fruit Seed", "Mango Seed", "Grape Seed",
        "Mushroom Seed", "Pepper Seed", "Cacao Seed"
    },
    CurrentOption = {"Carrot Seed"},
    MultipleOptions = false,
    Flag = "SeedsToBuy",
    Callback = function(SelectedOption)
        _G.SelectedSeedToBuy = SelectedOption[1]
        print("Selected seed to buy:", SelectedOption[1])
    end,
})

AutoFarmTab:CreateSlider({
    Name = "Select How Many To Buy",
    Range = {1, 100},
    Increment = 1,
    Suffix = " Seeds",
    CurrentValue = 1,
    Flag = "HowManyToBuy",
    Callback = function(Value)
        _G.AmountToBuy = Value
        print("Amount to buy:", Value)
    end,
})
