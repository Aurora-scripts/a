local Player = game.Players.LocalPlayer
local Character = workspace.NewCam
local AnimHandler = loadstring(game:HttpGet("https://raw.githubusercontent.com/ProudNamed/SuperLightning/refs/heads/main/AnimModule/MainModule"))()
local Walk = game:GetObjects("rbxassetid://81454660292340")[1]
Walk.Parent = Character
local WalkAnim = AnimHandler.new(Character, Walk)
WalkAnim:Play()

-- LocalScript inside StarterPlayer -> StarterPlayerScripts

local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local newCam = game.Workspace:WaitForChild("NewCam")
local torso = newCam:WaitForChild("Torso")
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:FindFirstChild("HumanoidRootPart")

torso.CFrame = hrp.CFrame * CFrame.new(1,-3,-7)

local function rotateTorso180()
    torso.CFrame = torso.CFrame * CFrame.Angles(0, math.pi, 0) -- Rotate by 180 degrees on the Y axis
end

rotateTorso180()

-- Ensure the camera is in first person and locked to the torso
camera.CameraType = Enum.CameraType.Scriptable

-- Function to update the camera position and orientation
local function updateCamera()
    -- Set the camera's position to be behind the 'Torso' part in 'NewCam'
    local offset = torso.CFrame.LookVector * 0 -- Adjust distance behind the torso (negative moves the camera behind)
    camera.CFrame = CFrame.new(torso.Position + offset, torso.Position + torso.CFrame.LookVector) -- Face where the torso is facing
end

-- Continuously update the camera to lock it behind the torso
game:GetService("RunService").RenderStepped:Connect(function()
    if WalkAnim.IsPlaying then
        updateCamera()  -- Update camera while animation is playing
    end
end)

-- Listener to detect when the animation ends and reset the camera
WalkAnim.Stopped:Connect(function()
    -- Reset the camera to the default
    camera.CameraType = Enum.CameraType.Custom
    -- Optionally, set the camera position back to the default
    camera.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 10), player.Character.HumanoidRootPart.Position)
end)
