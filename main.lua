function love.load()
  ball = {
    x = 395,
    y = 295,
    width = 10,
    height = 10,
    color = {255, 255, 255},
    speedX = 100,
    speedY = 100
  }

  net = {
    width = 5,
    height = 10,
    x = 397.5,
    startY = 0,
    gapBetween = 10
  }

  score = {
    player1 = 0,
    player2 = 0,
    font = love.graphics.newFont(30)
  }
end

function love.update(dt)
  ball.x = ball.x + ball.speedX * dt
  ball.y = ball.y + ball.speedY * dt
end

function love.draw()
  love.graphics.setColor(unpack(ball.color))
  love.graphics.rectangle('fill', ball.x, ball.y, ball.width, ball.height)

  drawNet()
  drawScores()
end

function drawNet()
  local y = net.startY

  love.graphics.setColor(255, 255, 255, 100)

  while y < 600 do
    love.graphics.rectangle('fill', net.x, y, net.width, net.height)
    y = y + net.gapBetween * 2
  end
end

function drawScores()
  love.graphics.setColor(255, 255, 255, 100)
  love.graphics.setFont(score.font)

  -- player 1
  local width = score.font:getWidth(score.player1)
  love.graphics.printf(score.player1, 0, 10, 350, 'right')

  -- player 2
  width = score.font:getWidth(score.player2)
  love.graphics.printf(score.player2, 450, 10, 350, 'left')
end
