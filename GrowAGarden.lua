wait ("0.2")
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Swifters Hub",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Swifters Hub",
   LoadingSubtitle = "by Awakening",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

Rayfield:Notify({
   Title = "Swift Hub Executed!",
   Content = "By: Awakening",
   Duration = 3,
   Image = 4483362458,
})

local Auto FarmTab = Window:CreateTab("Auto Farm", 0) -- Title, Image
local Auto FarmSection = Auto FarmTab:CreateSection("Auto Plant")

local AutoPlantToggle = Auto FarmTab:CreateToggle({
    Name = "Auto Plant Seeds",
    CurrentValue = false,
    Flag = "AutoPlantToggle",
    Callback = function(Value)
        -- Functionality for automatically planting seeds will go here
        print("Auto Plant Seeds toggled:", Value)
        -- Example:
        -- if Value then
        --     while task.wait(2) do -- Check every 2 seconds
        --         -- Logic to find empty plots and plant seeds
        --         print("Attempting to plant seeds...")
        --     end
        -- else
        --     print("Auto Plant Seeds disabled.")
        -- end
    end,
})

local AutoCollectToggle = Auto FarmTab:CreateToggle({
    Name = "Auto Collect Fruits",
    CurrentValue = false,
    Flag = "AutoCollectToggle",
    Callback = function(Value)
        -- Functionality for automatically collecting fruits will go here
        print("Auto Collect Fruits toggled:", Value)
        -- Example:
        -- if Value then
        --     while task.wait(1) do -- Check every 1 second
        --         -- Logic to find and collect mature fruits
        --         print("Attempting to collect fruits...")
        --     end
        -- else
        --     print("Auto Collect Fruits disabled.")
        -- end
    end,
})

local AutoDestroyToggle = Auto FarmTab:CreateToggle({
    Name = "Auto Destroy Grown Plants",
    CurrentValue = false,
    Flag = "AutoDestroyToggle",
    Callback = function(Value)
        -- Functionality for automatically destroying grown plants will go here
        print("Auto Destroy Grown Plants toggled:", Value)
        -- Example:
        -- if Value then
        --     while task.wait(3) do -- Check every 3 seconds
        --         -- Logic to find fully grown plants (after fruit collection?)
        --         -- and trigger the destroy action
        --         print("Attempting to destroy grown plants...")
        --     end
        -- else
        --     print("Auto Destroy Grown Plants disabled.")
        -- end
    end,
})

local Auto FarmSection = Auto FarmTab:CreateSection("Auto Buy Seeds")

local AutoBuyToggle = Auto FarmTab:CreateToggle({
    Name = "Auto Buy Seeds (if in stock!)",
    CurrentValue = false,
    Flag = "AutoBuyToggle",
    Callback = function(Value)
        -- Functionality for automatically buying seeds (if in stock) will go here
        print("Auto Buy Seeds (if in stock!) toggled:", Value)
        -- Example:
        -- if Value then
        --     while task.wait(5) do -- Check every 5 seconds
        --         -- Logic to check if seeds are in stock
        --         local seedsInStock = -- Function to determine available seeds
        --         if seedsInStock > 0 then
        --             -- Logic to find and buy seeds
        --             print("Attempting to buy seeds (in stock)...")
        --         else
        --             print("No seeds currently in stock.")
        --         end
        --     end
        -- else
        --     print("Auto Buy Seeds disabled.")
        -- end
    end,
})

local SeedsToBuyDropdown = Auto FarmTab:CreateDropdown({
    Name = "Select Seeds To Auto Buy",
    Options = {"Carrot Seed", "Strawberry Seed", "Blueberry Seed", "Orange Tulip Seed", "Tomato Seed", "Corn Seed", "Daffodil Seed", "Watermelon Seed", "Pumpkin Seed", "Apple Seed", "Bamboo Seed", "Coconut Seed", "Cactus Seed", "Dragon Fruit Seed", "Mango Seed", "Grape Seed", "Mushroom Seed", "Pepper Seed", "Cacao Seed"}, -- Replace with actual seed names
    CurrentOption = {"Carrot Seeds"}, -- Default selected seed
    MultipleOptions = false, -- Only allow selecting one seed at a time
    Flag = "SeedsToBuy",
    Callback = function(SelectedOption)
        print("Selected seed to buy:", SelectedOption[1])
        -- You can store the selected seed in a variable for use in the AutoBuyToggle callback
        _G.SelectedSeedToBuy = SelectedOption[1]
    end,
})

local HowManyToBuySlider = Auto FarmTab:CreateSlider({
    Name = "Select How Many To Buy",
    Range = {1, 100}, -- Minimum and maximum amount to buy
    Increment = 1, -- How much the slider changes with each step
    Suffix = " Seeds", -- Text to display after the number
    CurrentValue = 1, -- Default amount to buy
    Flag = "HowManyToBuy",
    Callback = function(Value)
        print("Amount to buy:", Value)
        _G.AmountToBuy = Value
    end,
})
