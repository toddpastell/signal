local game = setmetatable({
    eye = { x = 0, y = 0 },
    nodes = { ship:new() },
}, scene)
game.__index = game

d = 64

function game:update()
    for node in all(self.nodes) do
        node:update()
    end

    self.eye.x = lerp(self.eye.x, self.nodes[1].x - 64, 0.1)
    self.eye.y = lerp(self.eye.y, self.nodes[1].y - 64, 0.1)

    d += 3
    if d >= 256 then d = 32 end
end

function game:draw()
    cls()
    map()
    camera(self.eye.x, self.eye.y)
    for node in all(self.nodes) do
        node:draw()
    end

    circ(96, 64, d, 3)
    circ(96, 64, d - 8, 11)
    circ(96, 64, d - 16, 3)
    circ(96, 64, d - 24, 11)
end
