local star = {}
star.__index = star

function star:new(x, y, sp)
    local tbl = {
        x = x,
        y = y,
        sp = sp
    }
    return setmetatable(tbl, self)
end

function star:update()

end

function star:draw(layer)
    spr(self.sp, self.x + layer.x, self.y + layer.y)
    print(self.y, self.x, self.y + 16)
end
