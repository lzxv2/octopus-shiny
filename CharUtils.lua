local Char = {}

function Char:GetAll(path)
   local result = {}
   for _, model in pairs(path:GetChildren()) do
      local data = require(model:WaitForChild("data"))
    
      if data then
         result[model.Name] = {
            model,
            data
         }
      end
   end
   return result
end

local function getModelsCost(table)
   local result = {}
   for name, model in pairs(table)
      local value = model.data.cost
      results = {
        value
      }
   end
   return result
end

local function findClosest(table, target: number)
   local result = nil
   local minDif = math.huge
   local modelName = nil
   
   for name, value in pairs(table) do
      local Dif = math.abs(value - target)
      if Dif < minDif then
         minDif = Dif
         result = value
         modelName = name
      end
   end
   
   return result, modelName
end

local function autoSetup(model, defaultSpeed, defaultJump, defaultHealth, defaultMaxHealth, defaultHipHeight)
   -- Vou fazer ainda
end

function Char:GetNameByCost(table, value: number)
   for name, data in pairs(table)
      if data then
         local cost = data[2].cost
         if cost == value then
            return name
         end   
      end
   end
end

function Char:SetModel(player: Player, models, value: number)
   local Character = player.Character or player.CharacterAdded:Wait()
   if Character.Name == player.Name then
      Character:Destroy()
   end
   
   local prices = getModelsCost(models)
   local cost = findClosest(prices, value)
   if not cost then return end
   local modelName = Char:GetNameByCost(models, cost)
   
   if not modelName then 
     warn("Model: " .. modelName .. " not found.")
   end
   
   local modelData = models[modelName]
   local model = modelData[1]
   local data = modelData[2]
   
   if Character.Name ~= modelName and Character.Name ~= player.Name then
      local newChar = model:Clone()
      newChar.Parent = player
      newChar.Name = modelName
      autoSetup(newChar, data.WalkSpeed, data.JumpPower, data.Health, data.Health, data.HipHeight)
   end
end

return Char
