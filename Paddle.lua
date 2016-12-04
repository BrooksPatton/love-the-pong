local Paddle = {}
Paddle.__index = Paddle

function Paddle.new(playerType)
  local self = setmetatable({}, Paddle)
  self.type = playerType
  return self
end

return Paddle
