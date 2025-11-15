local pod = {}
pod.__index = pod

function pod:new(oy)
    local tbl = {
        oy = oy,
        x = 0,
        y = 0,
        wake = emitter:new()
    }
    return setmetatable(tbl, self)
end

function pod:update(ship)
    self.x = ship.x + self.oy * cos(ship.rot)
    self.y = ship.y + self.oy * sin(ship.rot)
    if ship.ddx != 0 then
        self.wake:spawn(self.x, self.y, -3 * sgn(ship.ddx), rnd(2) - 1)
    end
    if ship.ddy != 0 then
        self.wake:spawn(self.x, self.y, rnd(2) - 1, -3 * sgn(ship.ddy))
    end
    self.wake:update()
end

function pod:draw()
    self.wake:draw()
    spr(17, self.x, self.y)
end
