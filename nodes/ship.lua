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
            pod_w:new(14),
        },
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

    self.dx += self.ddx
    self.dy += self.ddy
    self.x += self.dx
    self.y += self.dy

    self.rot = lerp(self.rot, self.rot_tar, 0.2)

    for p in all(self.pods) do
        p:update(self, aim)
    end
end

function ship:draw()
    for p in all(self.pods) do
        p:draw()
    end
    spr(16, self.x, self.y)
end
