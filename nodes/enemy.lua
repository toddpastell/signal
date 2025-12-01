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
        vmax = 1.2,
        t = rnd(30),
        tmax = 30,
        mask = 0b1,
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
        self.dx = self.vmax * cos(a)
        self.dy = self.vmax * sin(a)
        local d = distance(self.x, self.y, ship.x, ship.y)
        if d > 256 then self.dead = true end
    end
    self.t += 1

    self.dx += self.ddx
    self.dy += self.ddy
    self.x += self.dx
    self.y += self.dy

    if not ship.dead and collide(self.x, self.y, 8, 8, ship.x, ship.y, 8, 8) then
        scene.current.die()
    end
end

function enemy:draw()
    spr(24, self.x, self.y)
end
