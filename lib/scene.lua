local scene = { current = nil }
scene.__index = scene

function scene:new()
    return setmetatable({}, self)
end

function scene:update()
end

function scene:draw()
end

function scene:enter()
end

function scene:leave()
end

function scene:set(s)
    if (self.current) then self.current:leave() end
    self.current = s
    s:enter()
end
