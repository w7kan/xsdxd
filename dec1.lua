-- Script Path: game:GetService("Players").Skywhirl7103.Backpack.Harpoon.LocalScript
-- Took 0s to decompile.
-- Executor: Potassium (v2.5.6)

-- Decompiled with Potassium's decompiler.

local RenderStepped = game:GetService("RunService").RenderStepped;
local Projectiles = game.Workspace.Events.Projectiles;
local WeaponDisplay = script.Parent:WaitForChild("WeaponDisplay");
local u1 = nil;
local u2 = nil;
local u3 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local Mouse = LocalPlayer:GetMouse();
local u4 = 1;
local u5 = false;
local u6 = false;
local u7 = false;
local u8 = false;
local u9 = 0;
script.Parent.Equipped:connect(function() -- Line: 27
    -- upvalues: u5 (ref), u1 (ref), WeaponDisplay (copy), u4 (ref), u8 (ref), u3 (ref), u2 (ref)
    u5 = true;
    u1 = WeaponDisplay:Clone();
    u1.Parent = game.Players.LocalPlayer.PlayerGui;
    u1.Frame.Ammo.Text = u4 .. " / " .. 1;
    game:GetService("ContextActionService"):BindAction("Reload", reload, false, "r");
    game:GetService("UserInputService").InputBegan:connect(function(p10) -- Line: 33
        if p10.KeyCode == Enum.KeyCode.ButtonX then
            reload();
        end;
    end);
    u1.Frame.ReloadReminder.MouseButton1Click:connect(reload);
    u1.Frame.ShootButton.MouseButton1Down:connect(fireWeapon);
    u1.Frame.ShootButton.MouseButton1Up:connect(stopFiring);

    if game:GetService("UserInputService").GamepadEnabled then
        u1.Frame.ReloadReminder.xboxHint.Visible = true;
        u1.Frame.ShootButton.xboxHint.Visible = true;
    end;

    if game:GetService("UserInputService").TouchEnabled == true then
        u1.Frame.Size = UDim2.new(0.1, 0, 0.1, 0);
        u1.Frame.Position = UDim2.new(1, -10, 0.4, 0);
        u1.Frame.ShootButton.Visible = true;
        u1.MobileAim.Visible = true;
        u8 = true;
    end;

    u3 = script.Parent.Parent.Humanoid:LoadAnimation(script.Parent.Idle);
    u2 = script.Parent.Parent.Humanoid:LoadAnimation(script.Parent.Shoot);
    u3:Play();
end);
script.Parent.Unequipped:connect(function() -- Line: 58
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u3 (ref), u2 (ref)
    u5 = false;
    u6 = false;
    u7 = false;
    local WeaponDisplay2 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("WeaponDisplay");

    if WeaponDisplay2 then
        WeaponDisplay2:Destroy();
    end;

    u3:Stop();
    u2:Stop();
    game:GetService("ContextActionService"):UnbindAction("Reload");
end);
game.Players.LocalPlayer.Character.Humanoid.Died:connect(function() -- Line: 72
    local WeaponDisplay2 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("WeaponDisplay");

    if WeaponDisplay2 then
        WeaponDisplay2:Destroy();
    end;
end);
Mouse.Button1Down:connect(function() -- Line: 81
    -- upvalues: u8 (ref)
    if not u8 then
        fireWeapon();
    end;
end);

function fireWeapon()
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u1 (ref), u4 (ref), u2 (ref), LocalPlayer (copy), Mouse (copy), u8 (ref), Projectiles (copy), u9 (ref), RenderStepped (copy)
    if u5 and not (u6 or u7) then
        if game:GetService("UserInputService").GamepadEnabled then
            u1.Frame.ReloadReminder.xboxHint.Visible = true;
        end;

        if u4 == 0 then
            u1.Frame.ReloadReminder.Visible = true;

            return;
        end;

        u6 = true;
        u4 = u4 - 1;

        if script.Parent:FindFirstChild("Harpoon") then
            script.Parent.Harpoon.Transparency = 1;
        end;

        if u4 == 0 then
            u1.Frame.ReloadReminder.Visible = true;
        end;

        u1.Frame.Ammo.Text = u4 .. " / " .. 1;
        local v11 = script.Parent.Handle.FireSound:Clone();
        v11.Parent = script.Parent.Handle;
        v11:Destroy();
        game.Workspace.Events.Projectiles.GunSound:FireServer(script.Parent.Handle);
        u2:Play();

        if LocalPlayer.Character and LocalPlayer.Character.Humanoid.Health > 0 then
            local Hit = Mouse.Hit;

            if u8 then
                local AbsolutePosition = u1.MobileAim.AbsolutePosition;
                local AbsoluteSize = u1.MobileAim.AbsoluteSize;
                local _ = (LocalPlayer.Character.Head.Position - game.Workspace.CurrentCamera.CFrame.p).Magnitude;
                local v12 = game.Workspace.CurrentCamera:ScreenPointToRay(AbsolutePosition.X + AbsoluteSize.X / 2, AbsolutePosition.Y + AbsoluteSize.Y / 2, 0);
                local Ray_new_ret = Ray.new(v12.Origin, v12.Direction * 10000);
                local _, v13 = game.Workspace:FindPartOnRay(Ray_new_ret, LocalPlayer.Character);
                Hit = CFrame.new(v13);
            end;

            local Position = script.Parent.Handle.Position;
            local lookVector = CFrame.new(Position, Hit.p).lookVector;
            Projectiles.ProjectileRenderEvent:FireServer(0, LocalPlayer.Name, 1, Position, Hit, 20, 1000, "Harpoon");
            coroutine.wrap(function() -- Line: 133
                -- upvalues: Position (copy), lookVector (copy), Projectiles (ref), u9 (ref), LocalPlayer (ref), Hit (ref), RenderStepped (ref)
                local v14 = game.ReplicatedStorage.Harpoon:Clone();
                v14.Parent = game.Workspace;
                local v15 = Position;
                local RaycastParams_new_ret = RaycastParams.new();
                RaycastParams_new_ret.FilterDescendantsInstances = { game.Players.LocalPlayer.Character, script.Parent.Harpoon, v14 };
                RaycastParams_new_ret.IgnoreWater = true;
                RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Blacklist;
                local v16 = 0;
                local v17 = 2;

                while v16 < 1000 do
                    Ray.new(v15, lookVector.unit * v17);
                    local v18 = workspace:Raycast(v15, lookVector.unit * v17, RaycastParams_new_ret);
                    local v19 = nil;

                    if v18 then
                        v15 = v18.Position;
                        v19 = v18.Instance;
                    else
                        v15 = v15 + lookVector.unit * v17;
                    end;

                    if v19 then
                        print(v19:GetFullName());
                        local Body = v19.Parent:FindFirstChild("Body");

                        if Body then
                            Projectiles.healthChange2:FireServer(Body.Parent.Identifier.Value, 65, u9);
                        end;

                        local Body2 = v19.Parent.Parent:FindFirstChild("Body");

                        if Body2 then
                            Projectiles.healthChange2:FireServer(Body2.Parent.Identifier.Value, 65, u9);
                        end;

                        Projectiles.ProjectileRenderEvent:FireServer(1, LocalPlayer.Name, 1, Position, Hit, 20, 1000, "Harpoon", v19, u9);
                        break;
                    end;

                    v14.CFrame = CFrame.new(v15, v15 + lookVector);

                    if v17 * 2 < 20 then
                        v17 = v17 * 2;
                    else
                        v17 = v17 ~= 20 and 20 or v17;
                    end;

                    v16 = v16 + v17;
                    RenderStepped:wait();
                end;

                v14:Destroy();
            end)();
        end;

        wait(0.7);
        u6 = false;
        u2:Stop();
    end;
end;

function stopFiring()
    -- upvalues: u5 (ref), u6 (ref)
    if u5 then
        u6 = false;
    end;
end;

Mouse.Button1Up:connect(function() -- Line: 197
    stopFiring();
end);
local u20 = 0;

function reload(p21, p22)
    -- upvalues: u7 (ref), u20 (ref), u6 (ref), u4 (ref), u1 (ref)
    if p22 and p22 == Enum.UserInputState.Cancel then
        return;
    end;

    if u7 then
        return;
    end;

    u20 = u20 + 1;
    u7 = true;
    u6 = false;
    script.Parent.Handle.ReloadSound:Play();
    wait(1.5);

    if u20 ~= u20 then
        print("cancel reload");

        return;
    end;

    u4 = 1;
    u1.Frame.Ammo.Text = u4 .. " / " .. 1;
    u1.Frame.ReloadReminder.Visible = false;

    if script.Parent:FindFirstChild("Harpoon") then
        script.Parent.Harpoon.Transparency = 0;
    end;

    u7 = false;
end;

game.Workspace.Events.S.SEvent2.OnClientEvent:connect(function(p23) -- Line: 267
    -- upvalues: u9 (ref)
    u9 = p23;
end);

-- // Function Dumper made by King.Kevin
-- // Script Path: game:GetService("Players").Skywhirl7103.Backpack.Harpoon.LocalScript

--[[
Function Dump: Unknown Name

Function Upvalues: Unknown Name
        1 [number] = 527.9556892132932

Function Constants: Unknown Name

====================================================================================================

Function Dump: Unknown Name

Function Upvalues: Unknown Name
        1 [number] = 527.9556892132932

Function Constants: Unknown Name

====================================================================================================

Function Dump: Unknown Name

Function Upvalues: Unknown Name
        1 [number] = 527.9556892132932

Function Constants: Unknown Name

====================================================================================================

Function Dump: Unknown Name

Function Upvalues: Unknown Name
        1 [number] = 527.9556892132932

Function Constants: Unknown Name

====================================================================================================

Function Dump: Unknown Name

Function Upvalues: Unknown Name
        1 [boolean] = false

Function Constants: Unknown Name
        1 [string] = fireWeapon

====================================================================================================

Function Dump: stopFiring

Function Upvalues: stopFiring
        1 [boolean] = false
        2 [boolean] = false

Function Constants: stopFiring

====================================================================================================

Function Dump: Unknown Name

Function Upvalues: Unknown Name
        1 [number] = 527.9556892132932

Function Constants: Unknown Name

====================================================================================================

Function Dump: Unknown Name

Function Upvalues: Unknown Name

Function Constants: Unknown Name
        1 [string] = stopFiring

====================================================================================================

Function Dump: Unknown Name

Function Upvalues: Unknown Name

Function Constants: Unknown Name
        1 [string] = game
        2 [Instance] = Ugc
        3 [string] = Players
        4 [string] = LocalPlayer
        5 [string] = PlayerGui
        6 [string] = WeaponDisplay
        7 [string] = FindFirstChild
        8 [string] = Destroy

====================================================================================================

Function Dump: Unknown Name

Function Upvalues: Unknown Name

Function Constants: Unknown Name
        1 [string] = KeyCode
        2 [string] = Enum
        3 [string] = ButtonX
        4 [EnumItem] = Enum.KeyCode.ButtonX
        5 [string] = reload

====================================================================================================

Function Dump: Unknown Name

Function Upvalues: Unknown Name
        1 [boolean] = false
        2 [Instance] = WeaponDisplay
        3 [Instance] = WeaponDisplay
        4 [number] = 0
        5 [boolean] = false
        6 [Instance] = Idle
        7 [Instance] = Shoot

Function Constants: Unknown Name
        1 [string] = Clone
        2 [string] = game
        3 [Instance] = Ugc
        4 [string] = Players
        5 [string] = LocalPlayer
        6 [string] = PlayerGui
        7 [string] = Parent
        8 [string] = Frame
        9 [string] = Ammo
        10 [string] =  / 
        11 [string] = Text
        12 [string] = ContextActionService
        13 [string] = GetService
        14 [string] = Reload
        15 [string] = reload
        16 [string] = r
        17 [string] = BindAction
        18 [string] = UserInputService
        19 [string] = InputBegan
        21 [string] = connect
        22 [string] = ReloadReminder
        23 [string] = MouseButton1Click
        24 [string] = ShootButton
        25 [string] = MouseButton1Down
        26 [string] = fireWeapon
        27 [string] = MouseButton1Up
        28 [string] = stopFiring
        29 [string] = GamepadEnabled
        30 [string] = xboxHint
        31 [string] = Visible
        32 [string] = TouchEnabled
        33 [string] = UDim2
        34 [string] = new
        36 [number] = 0.1
        37 [string] = Size
        38 [number] = 0.4
        39 [string] = Position
        40 [string] = MobileAim
        41 [string] = script
        43 [string] = Humanoid
        44 [string] = Idle
        45 [string] = LoadAnimation
        46 [string] = Shoot
        47 [string] = Play

====================================================================================================

Function Dump: fireWeapon

Function Upvalues: fireWeapon
        1 [boolean] = false
        2 [boolean] = false
        3 [boolean] = false
        4 [Instance] = WeaponDisplay
        5 [number] = 0
        6 [Instance] = Shoot
        7 [Instance] = Skywhirl7103
        8 [Instance] = Instance
        9 [boolean] = false
        10 [Instance] = Projectiles
        11 [number] = 527.9556892132932
        12 [RBXScriptSignal] = Signal RenderStepped

Function Constants: fireWeapon
        1 [string] = game
        2 [Instance] = Ugc
        3 [string] = UserInputService
        4 [string] = GetService
        5 [string] = GamepadEnabled
        6 [string] = Frame
        7 [string] = ReloadReminder
        8 [string] = xboxHint
        9 [string] = Visible
        10 [number] = 0
        11 [number] = 1
        12 [string] = script
        14 [string] = Parent
        15 [string] = Harpoon
        16 [string] = FindFirstChild
        17 [string] = Transparency
        18 [string] = Ammo
        19 [string] =  / 
        20 [string] = Text
        21 [string] = Handle
        22 [string] = FireSound
        23 [string] = Clone
        24 [string] = Destroy
        25 [string] = Workspace
        26 [string] = Events
        27 [string] = Projectiles
        28 [string] = GunSound
        29 [string] = FireServer
        30 [string] = Play
        31 [string] = Character
        32 [string] = Humanoid
        33 [string] = Health
        34 [string] = Hit
        35 [string] = MobileAim
        36 [string] = AbsolutePosition
        37 [string] = AbsoluteSize
        38 [string] = Head
        39 [string] = Position
        40 [string] = CurrentCamera
        41 [string] = CFrame
        42 [string] = p
        43 [string] = Magnitude
        44 [string] = X
        45 [number] = 2
        46 [string] = Y
        47 [string] = ScreenPointToRay
        48 [string] = Ray
        49 [string] = new
        51 [string] = Origin
        52 [number] = 10000
        53 [string] = Direction
        54 [string] = FindPartOnRay
        56 [string] = lookVector
        57 [string] = ProjectileRenderEvent
        58 [string] = Name
        59 [string] = coroutine
        60 [string] = wrap
        62 [string] = wait
        64 [number] = 0.7
        65 [string] = Stop

====================================================================================================

Function Dump: fireWeapon

Function Upvalues: fireWeapon
        1 [boolean] = false
        2 [boolean] = false
        3 [boolean] = false
        4 [Instance] = WeaponDisplay
        5 [number] = 0
        6 [Instance] = Shoot
        7 [Instance] = Skywhirl7103
        8 [Instance] = Instance
        9 [boolean] = false
        10 [Instance] = Projectiles
        11 [number] = 527.9556892132932
        12 [RBXScriptSignal] = Signal RenderStepped

Function Constants: fireWeapon
        1 [string] = game
        2 [Instance] = Ugc
        3 [string] = UserInputService
        4 [string] = GetService
        5 [string] = GamepadEnabled
        6 [string] = Frame
        7 [string] = ReloadReminder
        8 [string] = xboxHint
        9 [string] = Visible
        10 [number] = 0
        11 [number] = 1
        12 [string] = script
        14 [string] = Parent
        15 [string] = Harpoon
        16 [string] = FindFirstChild
        17 [string] = Transparency
        18 [string] = Ammo
        19 [string] =  / 
        20 [string] = Text
        21 [string] = Handle
        22 [string] = FireSound
        23 [string] = Clone
        24 [string] = Destroy
        25 [string] = Workspace
        26 [string] = Events
        27 [string] = Projectiles
        28 [string] = GunSound
        29 [string] = FireServer
        30 [string] = Play
        31 [string] = Character
        32 [string] = Humanoid
        33 [string] = Health
        34 [string] = Hit
        35 [string] = MobileAim
        36 [string] = AbsolutePosition
        37 [string] = AbsoluteSize
        38 [string] = Head
        39 [string] = Position
        40 [string] = CurrentCamera
        41 [string] = CFrame
        42 [string] = p
        43 [string] = Magnitude
        44 [string] = X
        45 [number] = 2
        46 [string] = Y
        47 [string] = ScreenPointToRay
        48 [string] = Ray
        49 [string] = new
        51 [string] = Origin
        52 [number] = 10000
        53 [string] = Direction
        54 [string] = FindPartOnRay
        56 [string] = lookVector
        57 [string] = ProjectileRenderEvent
        58 [string] = Name
        59 [string] = coroutine
        60 [string] = wrap
        62 [string] = wait
        64 [number] = 0.7
        65 [string] = Stop

====================================================================================================

Function Dump: fireWeapon

Function Upvalues: fireWeapon
        1 [boolean] = false
        2 [boolean] = false
        3 [boolean] = false
        4 [Instance] = WeaponDisplay
        5 [number] = 0
        6 [Instance] = Shoot
        7 [Instance] = Skywhirl7103
        8 [Instance] = Instance
        9 [boolean] = false
        10 [Instance] = Projectiles
        11 [number] = 527.9556892132932
        12 [RBXScriptSignal] = Signal RenderStepped

Function Constants: fireWeapon
        1 [string] = game
        2 [Instance] = Ugc
        3 [string] = UserInputService
        4 [string] = GetService
        5 [string] = GamepadEnabled
        6 [string] = Frame
        7 [string] = ReloadReminder
        8 [string] = xboxHint
        9 [string] = Visible
        10 [number] = 0
        11 [number] = 1
        12 [string] = script
        14 [string] = Parent
        15 [string] = Harpoon
        16 [string] = FindFirstChild
        17 [string] = Transparency
        18 [string] = Ammo
        19 [string] =  / 
        20 [string] = Text
        21 [string] = Handle
        22 [string] = FireSound
        23 [string] = Clone
        24 [string] = Destroy
        25 [string] = Workspace
        26 [string] = Events
        27 [string] = Projectiles
        28 [string] = GunSound
        29 [string] = FireServer
        30 [string] = Play
        31 [string] = Character
        32 [string] = Humanoid
        33 [string] = Health
        34 [string] = Hit
        35 [string] = MobileAim
        36 [string] = AbsolutePosition
        37 [string] = AbsoluteSize
        38 [string] = Head
        39 [string] = Position
        40 [string] = CurrentCamera
        41 [string] = CFrame
        42 [string] = p
        43 [string] = Magnitude
        44 [string] = X
        45 [number] = 2
        46 [string] = Y
        47 [string] = ScreenPointToRay
        48 [string] = Ray
        49 [string] = new
        51 [string] = Origin
        52 [number] = 10000
        53 [string] = Direction
        54 [string] = FindPartOnRay
        56 [string] = lookVector
        57 [string] = ProjectileRenderEvent
        58 [string] = Name
        59 [string] = coroutine
        60 [string] = wrap
        62 [string] = wait
        64 [number] = 0.7
        65 [string] = Stop

====================================================================================================

Function Dump: reload

Function Upvalues: reload
        1 [boolean] = false
        2 [number] = 0
        3 [boolean] = false
        4 [number] = 0
        5 [Instance] = WeaponDisplay

Function Constants: reload
        1 [string] = Enum
        2 [string] = UserInputState
        3 [string] = Cancel
        4 [EnumItem] = Enum.UserInputState.Cancel
        5 [number] = 1
        6 [string] = script
        8 [string] = Parent
        9 [string] = Handle
        10 [string] = ReloadSound
        11 [string] = Play
        12 [string] = wait
        14 [number] = 1.5
        15 [string] = print
        17 [string] = cancel reload
        18 [string] = Frame
        19 [string] = Ammo
        20 [string] =  / 
        21 [string] = Text
        22 [string] = ReloadReminder
        23 [string] = Visible
        24 [string] = Harpoon
        25 [string] = FindFirstChild
        26 [string] = Transparency

====================================================================================================

Function Dump: Unknown Name

Function Upvalues: Unknown Name
        1 [boolean] = false
        2 [boolean] = false
        3 [boolean] = false
        4 [Instance] = Idle
        5 [Instance] = Shoot

Function Constants: Unknown Name
        1 [string] = game
        2 [Instance] = Ugc
        3 [string] = Players
        4 [string] = LocalPlayer
        5 [string] = PlayerGui
        6 [string] = WeaponDisplay
        7 [string] = FindFirstChild
        8 [string] = Destroy
        9 [string] = Stop
        10 [string] = ContextActionService
        11 [string] = GetService
        12 [string] = Reload
        13 [string] = UnbindAction

====================================================================================================
]]
