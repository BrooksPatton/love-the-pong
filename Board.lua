local Board = {}
Board.__index = Board

function Board.new()
  local self = setmetatable({}, Board)

  self.scores = {
    player1 = 0,
    player2 = 0,
    font = love.graphics.newFont(50)
  }

  return self
end

function Board.draw(self)
  love.graphics.setColor(87, 142, 228)
  love.graphics.setFont(self.scores.font)
  love.graphics.print(self.scores.player1, 75, 50)
end

return Board
