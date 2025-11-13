local emitter = {}
emitter.__index = emitter

function emitter:new()
    local tbl = {
        particles = {}
    }
    return setmetatable(tbl, self)
end

function emitter:update()
    for p in all(self.particles) do
        if p.life <= 0 then del(self.particles, p) end
        p.life -= 1
        p.x += p.dx
        p.y += p.dy
        p.sp += 0.2
    end
end

function emitter:draw()
    for p in all(self.particles) do
        spr(p.sp, p.x, p.y)
    end
end

function emitter:spawn(x, y, dx, dy)
    local p = {
        x = x,
        y = y,
        dx = dx,
        dy = dy,
        life = 20,
        sp = 48,
    }
    add(self.particles, p)
end
