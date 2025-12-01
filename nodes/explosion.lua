local explosion = {}
explosion.__index = explosion

function explosion:new(x, y)
    local tbl = {
        x = x,
        y = y,
        sp = 35,
    }
    return setmetatable(tbl, self)
end

function explosion:update()
    self.sp += 0.5
    if (self.sp > 38) then self.dead = true end
end

function explosion:draw()
    spr(self.sp, self.x, self.y)
end
