local star = {}
star.__index = star

function star:new(x, y, sp)
    local df = rnd(0.01)
    local tbl = {
        x = x,
        y = y,
        sp = sp,
        f = rnd(),
        df = df,
        fmax = 1 + df * 3,
        t = rnd(30),
    }
    return setmetatable(tbl, self)
end

function star:update(layer)
    if (self.f > self.fmax) then
        self.f = 0
    end
    self.f += self.df

    self.t += 1
    if self.t > 30 then
        self.t = 0
        self.x -= flr((self.x - layer.x) / 128) * 128
        self.y -= flr((self.y - layer.y) / 128) * 128
    end
end

function star:draw(layer)
    spr(self.sp + self.f, self.x, self.y)
end
