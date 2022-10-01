function opponentNoteHit()
    if dadName == 'hexpun' then
        cameraShake('hud', 0.01, 0.1);
        health = getProperty('health')
        setProperty('health', health- 0.02);
    end
end