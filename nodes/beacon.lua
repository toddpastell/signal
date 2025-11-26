local beacon = {}
beacon.__index = beacon

function beacon:new(x, y)
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
        local d = distance(self.x, self.y, ship.x, ship.y)
        self.r = d - 64
        self.rmax = d + 64
    end


    if self.r ~= nil then
        if self.r > self.rmax then
            self.r = nil
        else
            self.r += 2
        end
    end

    if collide(self.x - 2, self.y - 2, 3, 3, ship.x, ship.y, 7, 7) then
        stop("hit")
    end
end

function beacon:draw()
    spr(self.sp, self.x - 4, self.y - 4)
    if self.r == nil then return end
    for i = 1, 4 do
        local radius = self.r + i * 4
        local col = (i % 2 == 0) and 3 or 11
        circ(self.x, self.y, radius, col)
    end
end

-- d = 64

-- -- todo remove
-- d -= 1
-- circ(96, 64, d, 3)
-- circ(96, 64, d - 8, 11)
-- circ(96, 64, d - 16, 3)
-- circ(96, 64, d - 24, 11)
