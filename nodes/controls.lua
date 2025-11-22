local controls = {}
controls.__index = controls

function controls:new()
    local tbl = {
        y = -64,
        hud = false
    }
    return setmetatable(tbl, self)
end

function controls:update()
    if btnp(5) then
        self.hud = not self.hud
    end
    self.y = lerp(self.y, self.hud and -85 or -126, 0.2)
end

function controls:draw(ship)
    camera(-8, self.y)
    rrectfill(0, 0, 112, 64, 2, 1)

    if not self.hud then return end

    map(0, 0, 2, 2, 16, 16)
    -- draw position
    camera(-26, self.y - 17)
    circ(0.001 * ship.x, 0.001 * ship.y, 1, 11)
    -- draw velocity
    camera(-26, self.y - 38)
    line(0.5 * sgn(ship.dx), 0, 2 * ship.dx, 0, 11)
    camera(-46, self.y - 18)
    line(0, 0.5 * sgn(ship.dy), 0, 2 * ship.dy, 11)
    camera(-50, self.y - 2)
    print("incoming transmis\nsion", 0, 0, 12)
    print("...", 0, 8, 12)
    print("...", 0, 16, 12)
end
