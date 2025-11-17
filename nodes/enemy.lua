local enemy = {}
enemy.__index = enemy

function enemy:new(x, y)
    local tbl = {
        x = x or 0,
        y = y or 0,
        dx = 0,
        dy = 0,
        ddx = 0,
        ddy = 0,
        t = rnd(30),
        tmax = 30,
    }
    return setmetatable(tbl, self)
end

function enemy:update(ship)
    self.ddx = 0
    self.ddy = 0

    -- ai controls
    if (self.t > self.tmax) then
        self.t = 0
        local a = atan2(ship.x - self.x, ship.y - self.y)
        self.dx = 2 * cos(a)
        self.dy = 2 * sin(a)
    end
    self.t += 1

    self.dx += self.ddx
    self.dy += self.ddy
    self.x += self.dx
    self.y += self.dy
end

function enemy:draw()
    spr(19, self.x, self.y)
end
