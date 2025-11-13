local intro = setmetatable({}, scene)
intro.__index = intro

function intro:update()
    if btn(5) then scene:set(game:new()) end
end

function intro:draw()
    cls()
    print("intro scene", 40, 60, 7)
    print("press ❎ to start", 30, 80, 6)
end
