local layer = {}
layer.__index = layer

function layer:new(t)
    local tbl = {
        t = t,
        x = 0,
        y = 0,
        nodes = {},
    }
    return setmetatable(tbl, self)
end

function layer:update(eye)
    self.x = flr(eye.x * self.t)
    self.y = flr(eye.y * self.t)
    for n in all(self.nodes) do
        n:update()
    end
end

function layer:draw()
    camera(self.x, self.y)
    for n in all(self.nodes) do
        n:draw(self)
    end
end
