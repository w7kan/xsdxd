local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local TEAM_SURVIVOR = "Survivor"
local lastAntiAfk = 0
local scriptEnabled = true

local function getLocalPlayer()
    local lp = Players.LocalPlayer
    if not lp then return nil end
    return lp
end

local function getHumanoid()
    local lp = getLocalPlayer()
    if not lp then return nil end
    local character = lp.Character
    if not character then return nil end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return nil end
    if humanoid.Health <= 0 then return nil end
    return humanoid
end

local function killSurvivor()
    local humanoid = getHumanoid()
    if humanoid then
        humanoid.Health = 0
    end
end

local function antiAfk()
    if os.clock() - lastAntiAfk < 30 then return end
    lastAntiAfk = os.clock()
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:Button1Down(Vector2.new(0, 0))
    end)
end

task.spawn(function()
    while task.wait(0.5) do
        if not scriptEnabled then continue end

        antiAfk()

        local lp = getLocalPlayer()
        if not lp then continue end

        if not lp.Character then continue end

        local humanoid = getHumanoid()
        if not humanoid then continue end

        local currentTeam = lp.Team
        if currentTeam and currentTeam.Name == TEAM_SURVIVOR then
            killSurvivor()
        end
    end
end)
