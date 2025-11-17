local controls = {}
controls.__index = controls

function controls:new()
    local tbl = {
        hud = false
    }
    return setmetatable(tbl, self)
end

function controls:update(ship)
    if btn(0) then
        ship.ddx = -0.1
        ship.rot_tar = 0.25
    end
    if btn(1) then
        ship.ddx = 0.1
        ship.rot_tar = 0.75
    end
    if btn(2) then
        ship.ddy = -0.1
        ship.rot_tar = 0
    end
    if btn(3) then
        ship.ddy = 0.1
        ship.rot_tar = 0.5
    end
    if btnp(5) then
        self.hud = not self.hud
    end
end

function controls:draw(ship)
    if not self.hud then return end
    camera(-8, -64)
    rrectfill(0, 0, 112, 64, 2, 1)
    map(0, 0, 2, 2, 16, 16)
    -- draw position
    camera(-26, -81)
    circ(0.001 * ship.x, 0.001 * ship.y, 1, 11)
    -- draw velocity
    camera(-26, -102)
    line(0.5 * sgn(ship.dx), 0, 2 * ship.dx, 0)
    camera(-46, -82)
    line(0, 0.5 * sgn(ship.dy), 0, 2 * ship.dy)
end
