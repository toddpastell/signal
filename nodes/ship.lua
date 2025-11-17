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
        rot = 0,
        rot_tar = 0,
        pods = {
            pod:new(8),
            pod:new(-8),
        },
        ctrl = controls:new(),
    }
    return setmetatable(tbl, self)
end

function ship:update()
    self.ddx = 0
    self.ddy = 0

    self.ctrl:update(self)

    self.dx += self.ddx
    self.dy += self.ddy
    self.x += self.dx
    self.y += self.dy

    self.rot = lerp(self.rot, self.rot_tar, 0.2)

    for p in all(self.pods) do
        p:update(self)
    end
end

function ship:draw()
    for p in all(self.pods) do
        p:draw()
    end
    spr(16, self.x, self.y)
end
