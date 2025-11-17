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
    }
    return setmetatable(tbl, self)
end

function star:update()
    if (self.f > self.fmax) then self.f = 0 end
    self.f += self.df
end

function star:draw()
    spr(self.sp + self.f, self.x, self.y)
end
