ico2 = {}
ico1 = {}

songstarted = false
function onCreatePost()
    ico2.order = getObjectOrder('iconP2')
    ico2.ogh = 0
    ico2.ogw = 0
    ico2.name = ''
    ico2.idlename = ''
    ico2.losename = ''
    ico2.offset = 0
    ico2.offsety = 0
    ico2.noxml = false

    ico1.order = getObjectOrder('iconP1')
    ico1.ogh = 0
    ico1.ogw = 0
    ico1.name = ''
    ico1.idlename = ''
    ico1.losename = ''
    ico1.winname = ''
    ico1.offset = 0
    ico1.offsety = 0
    ico1.noxml = false

    if string.lower(songName) == 'wacky' then
        ico1.name = 'icons/icon-dahlia'
        ico1.idlename = 'idle'
        ico1.losename = 'lose'
        ico1.winname = 'idle'
        ico2.name = 'icons/icon-amber'
        ico2.idlename = 'idle'
        ico2.losename = 'lose'
        ico2.winname = 'idle'
    else
        ico2.noxml = true
        ico1.noxml = true
    end

    if ico1.noxml == false then
        setProperty('iconP1.visible',false);
        makeAnimatedLuaSprite('theicon1', ico1.name, getProperty('iconP1.x'), 0)
        addAnimationByIndices('theicon1', 'idle', ico1.idlename, '0', 0)
        addAnimationByIndices('theicon1', 'lose', ico1.losename, '0', 0)
        addAnimationByIndices('theicon1', 'win', ico1.winname, '0', 0)
        addLuaSprite('theicon1')
        setObjectCamera('theicon1', 'hud')
        objectPlayAnimation('theicon1', 'idle')
        setObjectOrder('theicon1', ico1.order)
        setProperty('theicon1.y', getProperty('healthBar.y') - (getProperty('theicon1.height')/2) + ico1.offsety)

        setProperty('theicon1.flipX', true)
    end

    if ico2.noxml == false then
        setProperty('iconP2.visible',false);
        makeAnimatedLuaSprite('theicon2', ico2.name, getProperty('iconP2.x'), 0)
        addAnimationByIndices('theicon2', 'idle', ico2.idlename, '0', 0)
        addAnimationByIndices('theicon2', 'lose', ico2.losename, '0', 0)
        addAnimationByIndices('theicon2', 'win', ico2.winname, '0', 0)
        addLuaSprite('theicon2')
        setObjectCamera('theicon2', 'hud')
        objectPlayAnimation('theicon2', 'idle')
        setObjectOrder('theicon2', ico2.order)
        setProperty('theicon2.y', getProperty('healthBar.y') - (getProperty('theicon2.height')/2) + ico2.offsety)
    end

end

function onUpdatePost(elapsed)
    if ico1.noxml == false then
    setProperty('theicon1.x', getProperty('healthBar.x') + (getProperty('healthBar.width') * (remapToRange(getProperty('healthBar.percent'), 0, 100, 100, 0) * 0.01)) - ((getProperty('theicon1.width') - 150)/2) + ico1.offset + 25 - 27)
    setProperty('theicon1.y', getProperty('healthBar.y') - (150/2) - ((getProperty('theicon1.height') - 150)/2))
    end

    if ico2.noxml == false then
        setProperty('theicon2.x', getProperty('healthBar.x') + (getProperty('healthBar.width') * (remapToRange(getProperty('healthBar.percent'), 0, 100, 100, 0) * 0.01)) - ((getProperty('theicon2.width') - 150)/2) + ico2.offset - 100 - 27)
        setProperty('theicon2.y', getProperty('healthBar.y') - (150/2) - ((getProperty('theicon2.height') - 150)/2))
    end

    if ico1.noxml == false and songstarted == true then
        if getProperty('health') >= 1.60 then
            objectPlayAnimation('theicon1', 'win')
        elseif getProperty('health') <= 0.40 then
            objectPlayAnimation('theicon1', 'lose')
        else
            objectPlayAnimation('theicon1', 'idle')
        end
    end

    if ico2.noxml == false and songstarted == true then
        if getProperty('health') >= 1.60 then
            objectPlayAnimation('theicon2', 'lose')
        elseif getProperty('health') <= 0.40 then
            objectPlayAnimation('theicon2', 'win')
        else
            objectPlayAnimation('theicon2', 'idle')
        end
    end


    if songstarted == true then
        if ico1.noxml == false then
            setGraphicSize('theicon1', lerp(ico1.ogw, getProperty('theicon1.width'),  boundTo(1 - (elapsed * 9), 0, 1)))
            updateHitbox('theicon1')
        end
        if ico2.noxml == false then
            setGraphicSize('theicon2', lerp(ico2.ogw, getProperty('theicon2.width'),  boundTo(1 - (elapsed * 9), 0, 1)))
            updateHitbox('theicon2')
        end
    end

end

function remapToRange(value, start1, stop1, start2, stop2)
    return start2 + (value - start1) * ((stop2 - start2) / (stop1 - start1));
end

function onBeatHit()

    if songstarted == true then
	if curBeat % 2 == 0 then
        if ico2.noxml == false then
        setGraphicSize('theicon2', 150 *1.25, 150 *1.25)
        updateHitbox('theicon2')
        end
        if ico1.noxml == false then
        setGraphicSize('theicon1', 150 *1.25, 150 *1.25)
        updateHitbox('theicon1')
        end
	else
	    if ico2.noxml == false then
        setGraphicSize('theicon2', 150 *1.075, 150 *1.075)
        updateHitbox('theicon2')
        end
        if ico1.noxml == false then
        setGraphicSize('theicon1', 150 *1.075, 150 *1.075)
        updateHitbox('theicon1')
        end
	end
    end

end

function lerp(a, b, ratio)
	return a + (ratio * (b - a))
end

function boundTo(value, min, max)
    local newValue = value
    if newValue < min then
        newValue = min
    elseif newValue > max then
        newValue = max
    end
    return newValue
end

function onSongStart()
    ico2.ogw = getProperty('theicon2.width')
    ico2.ogh = getProperty('theicon2.height')
    ico1.ogw = getProperty('theicon1.width')
    ico1.ogh = getProperty('theicon1.height')
    songstarted = true
end
