local Paddle = {}
Paddle.__index = Paddle

function Paddle.new(playerType)
  local self = setmetatable({}, Paddle)
  self.type = playerType

  self.height = 100
  self.width = 25
  self.y = 0

  if playerType == 'player' then
    self.x = 0
    self.color = {87, 142, 228}
  else
    self.x = 800 - self.width
    self.color = {234, 113, 73}
  end

  return self
end

function Paddle.draw(self)
  love.graphics.setColor(self.color[1], self.color[2], self.color[3])
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Paddle
