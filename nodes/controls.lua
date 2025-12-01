local controls = {}
controls.__index = controls

function controls:new()
    local tbl = {
        y = -64,
        msg = { sp = 49, txt = "seek the signals" },
        hud = false,
        nodes = {
            button:new(0, 0, "ping", function()
                scene.current.p1.ping = { r = 0 }
                scene.current.ping()
            end),
            -- button:new(18, 0, "bcd"),
            -- button:new(36, 0, "bcd"),
            -- button:new(54, 0, "bcd"),
        },
    }
    return setmetatable(tbl, self)
end

function controls:update(aim)
    if btnp(4) then
        self.hud = not self.hud
        if self.msg.dead then
            self.msg.txt = ""
            self.msg.sp = 49
        end
    end
    self.y = lerp(self.y, self.hud and -85 or -126, 0.2)

    if #self.msg.txt != 0 then
        self.msg.sp += 0.1
        if self.msg.sp > 51 then self.msg.sp = 49 end
        if self.hud then
            self.msg.dead = true
        end
    end

    if not self.hud then return end

    for n in all(self.nodes) do
        n:update(aim.x0 - 50, aim.y0 + self.y - 25)
    end
end

function controls:draw(ship)
    camera(-8, self.y)
    rrectfill(0, 0, 112, 64, 2, 1)
    spr(self.msg.sp, 40, -6)

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
    print(self.msg.txt, 0, 0, 11)
    camera(-50, self.y - 25)
    for n in all(self.nodes) do
        n:draw()
    end
end
