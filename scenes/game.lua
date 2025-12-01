local game = setmetatable({}, scene)
game.__index = game

function game:new()
    local tbl = setmetatable({}, game)
    tbl.dead = false
    tbl.eye = { x = 0, y = 0 }
    tbl.aim = { x = 0, y = 0, x0 = 0, y0 = 0 }
    tbl.ctrl = controls:new()
    tbl.p1 = ship:new()
    tbl.nodes = {}
    tbl.step = 0
    tbl.t = 0

    add(tbl.nodes, beacon:new(32 + rnd(64), 32 + rnd(64), tbl.next))
    local l1 = layer:new(0.01)
    for i = 1, 10 do
        local n = star:new(rnd(128), rnd(128), 1)
        add(l1.nodes, n)
    end

    local l2 = layer:new(0.05)
    for i = 1, 10 do
        local n = star:new(rnd(128), rnd(128), 2)
        add(l2.nodes, n)
    end
    tbl.layers = { l1, l2 }
    return tbl
end

function game:update()
    self.aim.x0 = stat(32)
    self.aim.y0 = stat(33)
    self.aim.x = stat(32) + self.eye.x
    self.aim.y = stat(33) + self.eye.y

    self.ctrl:update(self.aim)

    self.p1:update(self.aim)

    for n in all(self.nodes) do
        n:update(self.p1)
        if n.dead then
            del(self.nodes, n)
        end
    end

    self.eye.x = lerp(self.eye.x, self.p1.x - 64, 0.2)
    self.eye.y = lerp(self.eye.y, self.p1.y - 64, 0.2)

    for l in all(self.layers) do
        l:update(self.eye)
    end

    if self.step > 2 then
        self.t += 1
        if self.t > 30 then
            self.t = 0
            local a = rnd()
            local n = enemy:new(self.p1.x + 72 * cos(a), self.p1.y + 72 * sin(a))
            n.vmax = rnd(2) + 1
            add(self.nodes, n)
        end
    end
end

function game:draw()
    cls()
    for l in all(self.layers) do
        l:draw()
    end
    camera(self.eye.x, self.eye.y)
    for n in all(self.nodes) do
        n:draw()
    end

    if not self.p1.dead then
        self.p1:draw()
        self.ctrl:draw(self.p1)
    else
        camera()
        print("game over", 50, 60, 11)
    end

    camera()
    spr(48, self.aim.x0, self.aim.y0)
end

function game.next()
    local g = scene.current
    g.step += 1
    if g.step == 1 then
        g.ctrl.msg.txt = "ai seeks you"
        g.ctrl.msg.dead = false
        local b = beacon:new(rnd(256) - 128, rnd(256) - 128, g.next)
        local a = atan2(g.p1.x - b.x, g.p1.y - b.y)
        b.dx = 0.9 * cos(a)
        b.dy = 0.9 * sin(a)
        add(g.nodes, b)
        local n = enemy:new(g.p1.x, g.p1.y - 72)
        add(g.nodes, n)
    elseif g.step == 2 then
        g.ctrl.msg.txt = "max speed\nincreased"
        g.ctrl.msg.dead = false
        g.p1.vmax = 2
        local b = beacon:new(rnd(256) - 128, rnd(256) - 128, g.next)
        b.sp = 18
        b.on = false
        add(g.nodes, b)
    elseif g.step == 3 then
        g.ctrl.msg.txt = "l-click to\nattack"
        g.ctrl.msg.dead = false
        add(g.p1.pods, pod_w:new())
    end
end

function game.ping()
    local g = scene.current
    if g.step == 2 then
        g.ctrl.msg.txt = "seek the orb"
        g.ctrl.msg.dead = false
        for n in all(g.nodes) do
            if n.tag == "beacon" then
                n.on = true
            end
        end
    else
        local n = enemy:new(g.p1.x, g.p1.y - 92)
        add(g.nodes, n)
    end
end

function game.die()
    local g = scene.current
    g.p1.dead = true
    add(g.nodes, explosion:new(g.p1.x, g.p1.y))
    add(g.nodes, explosion:new(g.p1.x + 9, g.p1.y))
    add(g.nodes, explosion:new(g.p1.x - 9, g.p1.y))
    add(g.nodes, explosion:new(g.p1.x, g.p1.y + 9))
    add(g.nodes, explosion:new(g.p1.x, g.p1.y - 9))
end
