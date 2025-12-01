function lerp(a, b, r)
    return a + (b - a) * r
end

function collide(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and
        x2 < x1 + w1 and
        y1 < y2 + h2 and
        y2 < y1 + h1
end

function distance(x1, y1, x2, y2)
    local dx = (x2 - x1) * 0.001
    local dy = (y2 - y1) * 0.001
    return sqrt(dx * dx + dy * dy) * 1000
end

function point_toward(x1, y1, x2, y2, dist)
    local d = distance(x1, y1, x2, y2)
    if d < dist then
        return x1, y1, d
    end
    local a = atan2(x2 - x1, y2 - y1)
    local x = x2 - dist * cos(a)
    local y = y2 - dist * sin(a)
    return x, y, dist
end

function draw_waves(x, y, r)
    for i = 1, 4 do
        local radius = r + i * 8
        local col = (i % 2 == 0) and 3 or 11
        circ(x, y, radius, col)
    end
end
