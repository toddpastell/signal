local beacon = {}
beacon.__index = beacon

function beacon:new(x, y, on_hit)
    local tbl = {
        x = x or 0,
        y = y or 0,
        dx = 0,
        dy = 0,
        ddx = 0,
        ddy = 0,
        sp = 20,
        t = 0,
        r = 0,
        rmax = 0,
        rx = 0,
        ry = 0,
        on = true,
        on_hit = on_hit,
        tag = "beacon",
    }
    return setmetatable(tbl, self)
end

function beacon:update(ship)
    self.dx += self.ddx
    self.dy += self.ddy
    self.x += self.dx
    self.y += self.dy

    self.t += 1

    if self.t > 60 then
        self.t = 0
        local x, y, d = point_toward(self.x, self.y, ship.x, ship.y, 320)
        self.r = d - 128
        self.rmax = d + 128
        self.rx = x
        self.ry = y
    end

    if self.r ~= nil then
        if self.r > self.rmax then
            self.r = nil
        else
            self.r += 16
        end
    end

    if collide(self.x - 2, self.y - 2, 3, 3, ship.x, ship.y, 7, 7) then
        self.dead = true
        self.on_hit()
    end
end

function beacon:draw()
    spr(self.sp, self.x - 4, self.y - 4)
    if self.r == nil then return end
    if self.on then
        draw_waves(self.rx, self.ry, self.r)
    end
end
