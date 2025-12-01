local pod_w = {}
pod_w.__index = pod_w

function pod_w:new()
    local tbl = {
        r = 14,
        x = 0,
        y = 0,
        rot = 0,
        rot_tar = 0,
    }
    return setmetatable(tbl, self)
end

function pod_w:update(ship, aim)
    if btn(5) then
        local d = distance(ship.x, ship.y, aim.x, aim.y)
        self.r = lerp(self.r, mid(14, 56, d), 0.3)
    else
        self.r = lerp(self.r, 14, 0.3)
    end

    self.rot_tar = atan2(aim.x - ship.x, aim.y - ship.y)
    self.rot = lerp(self.rot, self.rot_tar, 0.3)

    self.x = ship.x + self.r * cos(self.rot)
    self.y = ship.y + self.r * sin(self.rot)

    for n in all(scene.current.nodes) do
        if band(n.mask, 0b1) != 0 and not n.dead then
            local hit = collide(self.x + 2, self.y + 2, 3, 3, n.x, n.y, 7, 7)
            if hit then
                add(scene.current.nodes, explosion:new(n.x, n.y))
                n.dead = true
            end
        end
    end
end

function pod_w:draw()
    spr(18, self.x, self.y)
end
