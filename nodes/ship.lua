local ship = {}
ship.__index = ship

function ship:new(x, y)
    local tbl = {
        x = x or 0,
        y = y or 0,
        dx = 0,
        dy = 0,
        ddx = 0,
        ddy = 0,
        vmax = 1,
        rot = 0,
        rot_tar = 0,
        pods = {
            pod:new(8),
            pod:new(-8),
        },
        ping = nil,
    }
    return setmetatable(tbl, self)
end

function ship:update(aim)
    self.ddx = 0
    self.ddy = 0

    if btn(0) then
        self.ddx = -0.1
        self.rot_tar = 0.25
    end
    if btn(1) then
        self.ddx = 0.1
        self.rot_tar = 0.75
    end
    if btn(2) then
        self.ddy = -0.1
        self.rot_tar = 0
    end
    if btn(3) then
        self.ddy = 0.1
        self.rot_tar = 0.5
    end

    self.dx = mid(self.dx + self.ddx, -self.vmax, self.vmax)
    self.dy = mid(self.dy + self.ddy, -self.vmax, self.vmax)
    self.x += self.dx
    self.y += self.dy

    self.rot = lerp(self.rot, self.rot_tar, 0.2)

    if self.ping then
        self.ping.r += 16
        if self.ping.r > 128 then self.ping = nil end
    end

    for p in all(self.pods) do
        p:update(self, aim)
    end
end

function ship:draw()
    if self.ping then
        draw_waves(self.x, self.y, self.ping.r)
    end
    for p in all(self.pods) do
        p:draw()
    end
    spr(16, self.x, self.y)
end
