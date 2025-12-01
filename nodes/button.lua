local button = {}
button.__index = button

function button:new(x, y, txt, on_click)
    local tbl = {
        x = x,
        y = y,
        txt = txt,
        col = 3,
        on_click = on_click
    }
    return setmetatable(tbl, self)
end

function button:update(x, y)
    local over = collide(self.x, self.y, 17, 7, x, y, 6, 6)
    self.col = over and 11 or 3
    if over and btnp(5) then
        self.on_click()
    end
end

function button:draw()
    rect(self.x, self.y, self.x + 18, self.y + 8, self.col)
    print(self.txt, self.x + 2, self.y + 2)
end
