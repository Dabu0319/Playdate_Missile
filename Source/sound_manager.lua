local pd <const> = playdate
local snd <const> = pd.sound

 SoundManager = {}

local sounds = {}


function SoundManager.init()
    --sounds.fire = snd.sampleplayer.new("sounds/fire")
    sounds.destroy = snd.fileplayer.new("sounds/explosion01")
    sounds.bgm = snd.fileplayer.new("sounds/bgm")
end


function SoundManager.playEffect(soundName)
    local sound = sounds[soundName]
    if sound then
        sound:play()
    else
        print("Sound not found:", soundName)
    end
end


function SoundManager.playBGM(loop)
    if sounds.bgm then
        sounds.bgm:play(loop and 0 or 1) 
    else
        print("BGM not found")
    end
end

function SoundManager.resetBGM()
    if sounds.bgm then
        sounds.bgm:stop() 
        sounds.bgm:play(0) 
    else
        print("BGM not found")
    end
end


function SoundManager.stopBGM()
    if sounds.bgm then
        sounds.bgm:stop()
    end
end

function SoundManager.setBGMVolume(volume)
    if sounds.bgm then
        sounds.bgm:setVolume(volume)
    end
end

return SoundManager
