local pod_w = {}
pod_w.__index = pod_w

function pod_w:new(oy)
    local tbl = {
        oy = oy,
        x = 0,
        y = 0,
        rot = 0,
        rot_tar = 0,
    }
    return setmetatable(tbl, self)
end

function pod_w:update(ship, aim)
    self.rot_tar = atan2(aim.x - ship.x, aim.y - ship.y)
    self.rot = lerp(self.rot, self.rot_tar, 0.1)

    self.x = ship.x + self.oy * cos(self.rot)
    self.y = ship.y + self.oy * sin(self.rot)
end

function pod_w:draw()
    spr(18, self.x, self.y)
end
