local game = setmetatable({}, scene)
game.__index = game

d = 64

function game:new()
    local tbl = setmetatable({}, game)
    tbl.eye = { x = 0, y = 0 }
    tbl.p1 = ship:new()
    tbl.nodes = { tbl.p1 }
    local l1 = layer:new(0.99)
    for i = 1, 10 do
        local n = star:new(rnd(128), rnd(128), 3)
        add(l1.nodes, n)
    end
    local l2 = layer:new(0.96)
    for i = 1, 10 do
        local n = star:new(rnd(128), rnd(128), 2)
        add(l2.nodes, n)
    end
    tbl.layers = { l1, l2 }
    return tbl
end

function game:update()
    for node in all(self.nodes) do
        node:update()
    end

    self.eye.x = lerp(self.eye.x, self.p1.x - 64, 0.1)
    self.eye.y = lerp(self.eye.y, self.p1.y - 64, 0.1)

    for l in all(self.layers) do
        l:update(self.eye)
    end

    d += 3
    if d >= 256 then d = 32 end
end

function game:draw()
    cls()
    -- map()
    camera(self.eye.x, self.eye.y)
    for l in all(self.layers) do
        l:draw()
    end
    for node in all(self.nodes) do
        node:draw()
    end

    circ(96, 64, d, 3)
    circ(96, 64, d - 8, 11)
    circ(96, 64, d - 16, 3)
    circ(96, 64, d - 24, 11)
end
