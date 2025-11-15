--// Auto Chat + Cooldown Bars by Azael //--
--// Uses TextChatService for modern Roblox chat //--

local systemDisabled = false
systemDisabled = false
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")


--// Chat lines
local keyChats = {
	Q = {
		"I HOPE YOU LIKE IT! I PUT MY HEART INSIDE IT!", "I SCRATCH YOUR BACK! IN RETURN, YOU PEEL OFF MINE!", "I-I.C.U ON PAYDAY!",
		"EAT, IT IS GOOD FOR YOU, I ASSURE YOU THAT THERE'S MORE COMING TODAY!", "I GLITTER IN THE STROBE LIGHT, AND I BLOAT UNDER THE WATER!", "TEACH ME HOW TO LIE, TEACH ME HOW TO TRACE THE CALLER!", "ALWAYS DOING THE SAME THING! SAME THING! SAME THING!", "ROLL THE KATAMARI!", "MURDER EVERYONE YOU KNOW, AND GO AND MAKE A BIG BAG!", "BLOOD, LOVE, CANNIBAL!", "CAN I GET !!!!!! UP ENOUGH TO MAKE ME VOMIT BACK UP THE !!!!! THEY MADE ME TAKE?", "MY LUNGS POP, I CAN'T CRY!", "FATAL, COMA, GETTING CLOSER, I BRACE FOR IMPACT!", "I give permission for the right price.", "M-Make no decision per the deadline.", "ANIMAL!", "IF I DO IT EVERY DAY, AND IF I DO IT EVERY WEEK, THEN I MIGHT BECOME A BETTER MAN YOU WANTED OUT OF ME!", "I GOT LUCKY, I DO IT ALL THE TIME! I DO IT 'CAUSE I LIKE IT, AND I LIKE IT 'CAUSE IT'S MINEEEE!", "I-I-IT'S YOUR PROBLEM.", "I'M ON DUMB, !!!!! YOU CAN'T TELL THAT I MOVE, STUPID!", "FUNCRUSHER PLUS TO THESE !!!!!!, YOUR BUDGET'S NOTHING TO THIS!", "TELL YOU TO GO HIT A LICK, SO THEY CAN GO CLEAN OUT YOUR HOME!", "THESE DISTRACTED POCKETS REMAIN THE EASIEST PICKED! IF IT AIN'T YOUR PRESENTATION, THEY'LL GET ON YOU FOR YOUR SKIN!"
	},
	E = {
		"GUN SHOTS THROUGH MY DOOR!", "SETTLE THE SCORE!",
		"SYCOPHANT CYCLICAL HYPER-DIGITAL!", "TRY TO GROW A SPINE!", "SPIDERS SHOOTING OUT OF YOUR GUTS!", "YEAH, I GOT IT IN MY CLUTCH! I GOT THE TRACKER ON ME!", "LAST THING I WANNA SEE IS YOUR !!!!!!!!!!!!! FACE!", "BATHE. IN. BLO-BLO-BLO-BLOOD!", "E-E-E-Eyes on the prize, ok?", "I BET I'LL BE BETTER THAN EVER, WHEN I GET TO RUN AWAY WITH ALL OF MY MISTAKES!", "WE LOCK OUR LEGS AND START TO DROWN!", "I GET UP AND BITE FOR ANOTHER TASTE!", "MY LIMBS STRESS AND SHATTER!", " GO ON, SHOTGUN, SPLATTER, PAINT THE SHOWER, SEE WHAT HAPPENS!", "Attacking vertical.", "I-I-IT'S YOUR PROBLEM.", "YEAH, I WANT IT. I WANT IT QUITE A LOT! I'M IN IT 'CAUSE I CAN BE, YOU CAN'T TELL ME THAT I'M NOT!", "E-E-EVERYDAY I TAKE A MINUTE OF YOUR TIME, I KEEP THEM IN A BOX, I ORGANIZE THEM ALL BY SI-I-I-I-I-I-I-IZE!", "TWO GLOCKS, BIG !!! LIKE TRACER!", "!!!!! WE DUMP, !!!!! SHOOTING EVERYONE LIKE CUPID!", "I'LL TURN THIS FUNCTION TO BITS! JUMP IN, I'M DUMPING THE CLIP!", "NOTHING ON THE INTERNET GON' HELP YOU WITH YOUR WOES!", "Slamming like bullets into deer skin.", "Watch him run."
	},
	F = {
		"I-I-IT'S YOUR PROBLEM.", "I GOT CELLOPHANE, WRAPPED AROUND THE LINING OF MY THROAT!",
		"YOU'RE RUNNING OUT OF TIME!", "THINK TWICE, THINK TWICE, THINK TWICE, THINK TWICE!", "I WANNA BE CATATONIC, WHERE I CAN'T EVEN THINK!", "TOO FAST! THEY CANNOT CATCH ME, I'M TOO QUICK, !!!!!!", "AND I'M GONE!", "GOT A BIG SHARP KNIFE, IT'S MY OWN X-RAY!", "ENTROPY, I LET THE WATER FLOW!", "I WILL END UP ON THE NEWS, BEFORE I END UP IN YOUR BASEMENT!", "I AM NEW GOD! GONNA SMEAR YOU ON THE PAVEMENT!", "LOVE! SICK! CANNIBAL!", "UNDER THE COVERS MAKE YOU SHUDDER, CAUSE I KNOW JUST WHAT I WANNA !!!!!!! TAKE!", "I'M JUST HERE TO PUSH UR T3MPRR, PUT ME IN MY GRAVE!", "I SPRINT, RUN FOR COVER!", "THIS IS MY LIFE, AND YOU CAN NEVER TAKE THAT!", "GOING, FASTER, BREAK NECK, SHATTER, I LEARN MY LESSON!", "You stole just what I need.", "IT'S A FUNNY LITTLE CYCLE, I DO IT WHILE I FALL ASLEEP!", "I-I-IT'S YOUR PROBLEM.", "SIMPLE, I GET TO BE DUMB, YOU GET TO EXERCISE CONTROL!", "!!!!!! I'M IN YOUR CITY, COME CATCH ME! CAME BY HIMSELF, HE GON LEAVE IN A BAGGIE!", "CHOKESLAM A BEAT, UNDERTAKER!", "BETTER RUN, QUICK! AIN'T NO TELLING WHAT I'M DOING, AIN'T NO TELLING WHAT I'M USING! PICKED MY LIFE AND HOW I'LL LOSE IT, YEAH!", "KEEP THROWING FAITH IN A HOLE, IT'S POPULATION CONTROL!", "Watch him run.", "THE MORE YOU STOP, THE MORE I GO!", "CAR GO ZOOM!"
	}
}

local hurtChats = {
	"NO MATTER WHAT WE DO, WE END UP ON SOMEONE ELSE'S PLATE!", "METAL SHARDS INSIDE MY VOMIT!", "YOU GOT EXACTLY WHAT YOU WANT!",
	"P-PUSH UR T3MPRR!", "YOU'RE TOO ANGRY!", "OH MY GOD, SHUT THE !!!! UP!", "YOU JUST TALK !!!! ONLINE!", "LAST TRY!", "MY SPITE IS ALL THAT I HAVE LEFT!", "I DIE JUST RIGHT!", "YOU'LL FIND MY SMOKING BODY, !!!! IN WIRES OVERHEAD-HEAD-HEAD!", "JUST A DOLL OF FLESH!", "GOT BLADES ON MY WALL, MY EYES ARE BLOODSHOT!", "CLUTTERING UP MY VISION WITH THE FISSURES THAT ILLUMINATE YOUR FIGUREEEEE!", "IT'S NOT CAUSE I DON'T LIKE YOU, I DON'T WANNA SEE YOUR FACE!", "WE NEVER STOP BLEEDING!", "LYMPH NODE INFECTION!", "I-I-I-I-I will find you in the nightlife.", "I-I-I will kill you in my next life.", "You got a valid fight.", "ARE YOU STUPID?", "I-I-IT'S YOUR PROBLEM.", "E-E-E-E-EXERCISE CONTROL!", "I-I-I JUST MAKE THIS !!!! SO YOU CAN LOOSE YOUR- A-A-AAAAAAAAAA!!", "BOY, THAT'S NASTY WORK!", "HIT THAT !!!!! MATT WALSH WITTA LAZER, I-I-I AIN'T !!!!!! WITH YOU, BOY, YOU A CHASER!", "That was incredible, that was... You just had a near death experience!", "That's what it feels like when you feel like you're gonna die. It's powerful isn't it?", "There's an animal in you.", "Watch him run.", "DO YOUR BEST, I'LL DO ONE BETTER!", "A-A-AAAAAAAAAAAAAAAAAAAAA! WHAT THE !!!! IS WRONG WITH YOU?!", "BLOOD BEHIND MY EYES, WHEN I TRY TO SLEEP AT NIGHT!", "I GOT BITE MARKS ON MY STOMACH, THAT WEREN'T THERE BEFO-O-O=ORE!"
}

local idleChats = {
	"WELLNESS CHECK AT 2 A.M., !!!!!, THEY WILL FIND ME DEA-DEA-DEA-DEAD!", "OPEN SORES COVER MY BODY, TREAT ME LIKE YOUR PE-PE-PE-P3T!",
	"I LIVE ON YOUR LCD SCREEN, I LIVE IN THE RUBBER, RUBBER!", "!!!! MY NECK, AND THEN JUST WATCH ME GLOW!",
	"I WAS INSPIRED NOT TO CU-CU-CU-CUT!", "I-I-IV TUBE INSIDE MY ARM!", "I BET YOU FEEL JUST GREAT! WELL, I FEEL SUBLIME!",
	"R-RUSTY FINGERS THROUGH THE GRATE, TELLING ME YOUR ALL MINE!", "PUT THEM IN A ROT CAGE!", "I woke up.", "All I could taste was blood.", "HEY, LET'S GO YOUR ON A ROLL! GO ON, LOSE YOUR SELF-CONTROL! GOT NO PLACE I'D RATHER GO, 'CAUSE I LOST MY MIND IN LATE SEPTEMBER!'", "BRUISES ON MY NEC-NEC-NEC-NECK!", "SKULL-WIDE ENTRANCE! THOUGHTS SPILL, NO RETENTION!", "WASTED, NO MORE! DRY MOUTH, SEVERAL LOCKS ON THE DOOR!", "THAT'S JUST WHO I AM, IT'S JUST MY RADIO!", "I'VE ALWAYS STRUGGLED WITH MY HONESTY!", "NEXT TIME, I MAKE CERTAIN, THAT I SHOOT FOR FINAL COMPRESSION!", "Oh, it's easy, I lost to time.", "Got a fever of a hundred, and I'm feeling alright.", "Made it outta life in prison, without even a fine.", "Made it out with no convictions, I like to be bright.", "I'm on a mission, gonna act right-right-right.", "I LIKE LYING TO MYSELF THAT I LIKE EVERYONE I MEET!", "IF YOU EVER HEAR ME BREATHING, THEN THAT BREATHING IS A JOKE!", "I-I-IT'S YOUR PROBLEM.", "I'M IN YOUR CITY, !!!!!! I'M IN YOUR CITY, YUH!", "TALK, ON THE TEAM! OKAY, !!!!!, YO' WHOLE PACK GET MERC'D!", "WHY YOU WORRIED 'BOUT MY GUAP, WHEN YOU AIN'T EVEN STACKED IT FIRST!", "DO ME A FAVOR! I AIN'T DOIN' YA DIRTY IF I PAID FIRST!", "Y-Yeah, I'm sorry, I'm geeked off a !!!!!! Monday.", "Anybody you need to make peace with in this world? Before you go?", "Look at possum, there he lies. Children meet his lifeless eyes, see his nasty legs and tongue. When he wakens, watch him run.", "The rise.", "I hope to see you, when it hits morning. But it's just empty, beside my body.", "I just can't wake up, again without you.", "Head in, ceiling fan goes rolling.", "I-I-I-I GOT A DSI AT A LIMITED RATE! IT'S A HELL OF A !!!!, AND IT'S A HELL OF A RAGE!", "GOT A CRT AND ONLY SEVEN MORE DAYS, 'T-T-TIL I DROP COLD DEAD FROM THE CLOT IN MY BRAIN!", "I'M MADE OF DEAD MEAT, AND I GOT NO TASTE AND I WON'T LET UP 'TIL I GET MY WAY!", "DIAL NUMBERS, WATCH YOUR TONE! CLOCKWORK, WIND UP ALL ALONE!", "CORPSE LOCKED IN THE BATHROOM, BLOOD INSIDE MY SINK!", "B-B-BLEEDING OUT INSIDE MY CLOSET, THE SECRETS I WILL KEEP!"
}

--// Config
local keyCooldownTimes = {
	Q = 15,
	E = 20,
	F = 30
}

local hurtCooldownTime = 8
local idleInterval = {45,60}

--// Helper: Chat safely
local function chat(msg)
	if systemDisabled then return end
	TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
end


--// Create UI for cooldown bars
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CooldownBarsUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local function createBar(name, positionX)
	local frame = Instance.new("Frame")
	frame.Name = name .. "Bar"
	frame.Size = UDim2.new(0, 100, 0, 10)
	frame.Position = UDim2.new(0.5, positionX, 1, -50)
	frame.AnchorPoint = Vector2.new(0.5, 1)
	frame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	frame.BorderSizePixel = 0
	frame.Parent = screenGui
	
	local fill = Instance.new("Frame")
	fill.Name = "Fill"
	fill.Size = UDim2.new(1, 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
	fill.BorderSizePixel = 0
	fill.Parent = frame
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = Color3.fromRGB(255,255,255)
	label.Font = Enum.Font.GothamBold
	label.TextScaled = true
	label.Parent = frame
	
	return fill
end

-- 3 bars for Q, E, F
local barQ = createBar("Q", -120)
local barE = createBar("E", 0)
local barF = createBar("F", 120)

-- Re-enable system if script is re-executed
systemDisabled = false

-- 3 cooldown bars already created: barQ, barE, barF
local keyBars = {Q = barQ, E = barE, F = barF}

-- RESET ALL BARS VISUALLY
for _, bar in pairs(keyBars) do
	bar.Size = UDim2.new(0,0,1,0)
	bar.BackgroundColor3 = Color3.fromRGB(0,255,100)
end

-- RESET KEY/HURT COOLDOWNS
local keyCooldowns = {}
local hurtCooldown = false

player.CharacterAdded:Connect(function(newChar)
	if systemDisabled then return end

	-- Shut down the system if the character respawns in any way
	systemDisabled = true

	-- Optional: gray out all cooldown bars
	for _, bar in pairs(keyBars) do
		bar.Size = UDim2.new(0,0,1,0)
		bar.BackgroundColor3 = Color3.fromRGB(120,120,120)
	end
end)

--// Cooldown animation helper
local function startCooldownBar(bar, duration)
	bar.Size = UDim2.new(0, 0, 1, 0)
	bar.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
	
	local tween = TweenService:Create(bar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(0, 255, 100)
	})
	tween:Play()
end

--// Key Press (3 sec cooldown)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if systemDisabled then return end
	if gameProcessed then return end
	
	local key = input.KeyCode.Name
	if keyChats[key] and not keyCooldowns[key] then

		-- Get the correct cooldown for THIS key
		local cd = keyCooldownTimes[key]
		if not cd then return end

		keyCooldowns[key] = true

		local line = keyChats[key][math.random(1, #keyChats[key])]
		chat(line)

		if keyBars[key] then
			startCooldownBar(keyBars[key], cd)
		end
		
		task.delay(cd, function()
			if not systemDisabled then
				keyCooldowns[key] = false
			end
		end)
	end
end)

--// Hurt Reaction (5 sec cooldown)
local lastHealth = humanoid.Health
humanoid.HealthChanged:Connect(function(newHealth)
	if systemDisabled then return end
	if newHealth < lastHealth and not hurtCooldown then
		
		hurtCooldown = true
		
        -- Pick a random message
		local index = math.random(1, #hurtChats)
		local line = hurtChats[index]
		chat(line)

        -- If FINAL hurt message was chosen…
		local isFinalMessage = (index == #hurtChats)

        if isFinalMessage then
            -- Wait for death
            task.spawn(function()
                humanoid.Died:Wait()

                -- PERMANENTLY disable everything
                systemDisabled = true

                -- Optional: make all bars instantly grey-out
                for _, bar in pairs(keyBars) do
                    bar.Size = UDim2.new(0,0,1,0)
                    bar.BackgroundColor3 = Color3.fromRGB(120,120,120)
                end
            end)
        end

		task.delay(hurtCooldownTime, function()
			if not systemDisabled then
				hurtCooldown = false
			end
		end)
	end
	lastHealth = newHealth
end)


--// Idle / walking chatter (every 10–15 sec)
task.spawn(function()
	while true do
		task.wait(math.random(idleInterval[1], idleInterval[2]))
		if systemDisabled then return end

		local line = idleChats[math.random(1, #idleChats)]
		chat(line)
	end
end)
