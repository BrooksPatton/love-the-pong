Paddle = require('Paddle')
Board = require('Board')

function love.load()
  player1Paddle = Paddle.new('player')
  aiPaddle = Paddle.new('ai')
  board = Board.new()
end

function love.draw()
  player1Paddle:draw()
  aiPaddle:draw()
  board:draw()
end
