local layer = {}
layer.__index = layer

function layer:new(r)
    local tbl = {
        r = r,
        x = 0,
        y = 0,
        nodes = {},
    }
    return setmetatable(tbl, self)
end

function layer:update(eye)
    self.x = flr(eye.x * self.r)
    self.y = flr(eye.y * self.r)
    for n in all(self.nodes) do
        n:update(self)
    end
end

function layer:draw()
    camera(self.x, self.y)
    for n in all(self.nodes) do
        n:draw(self)
    end
end
