function love.load()
  gameStarted = false

  ball = resetBall()

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

  paddle1 = {
    x = 10,
    y = 280,
    height = 40,
    width = 10,
    direction = nil,
    speed = 400
  }

  paddle2 = {
    x = 780,
    y = 280,
    height = 40,
    width = 10,
    speed = 400,
    direction = nil
  }

  gameStarted = true
end

function love.update(dt)
  ball.x = ball.x + ball.speedX * dt
  ball.y = ball.y + ball.speedY * dt

  if ball.y + ball.height > 600 then
    ball.speedY = ball.speedY * -1
    ball.y = 600 - ball.height
  end

  if ball.y < 0 then
    ball.speedY = ball.speedY * -1
    ball.y = 0
  end

  if ball.x < paddle1.x + paddle1.width and ball.y > paddle1.y and ball.y < paddle1.y + paddle1.height then
    ball.speedX = ball.speedX * -1
    ball.x = paddle1.x + paddle1.width
  end

  if ball.x + ball.width > paddle2.x and ball.y > paddle2.y and ball.y < paddle2.y + paddle2.height then
    ball.speedX = ball.speedX * -1
    ball.x = paddle2.x - paddle2.width
  end

  if paddle1.direction == 'up' and paddle1.y > 0 then
    paddle1.y = paddle1.y - paddle1.speed * dt
  elseif paddle1.direction == 'down' and paddle1.y + paddle1.height < 600 then
    paddle1.y = paddle1.y + paddle1.speed * dt
  end

  if ball.x + ball.width < 0 then
    playerScores('player2')
    ball = resetBall()
    increaseDifficulty()
  elseif ball.x > 800 then
    playerScores('player1')
    ball = resetBall()
    increaseDifficulty()
  end

  moveAIPaddle(dt)
end

function love.draw()
  love.graphics.setColor(unpack(ball.color))
  love.graphics.rectangle('fill', ball.x, ball.y, ball.width, ball.height)

  love.graphics.rectangle('fill', paddle1.x, paddle1.y, paddle1.width, paddle1.height)
  love.graphics.rectangle('fill', paddle2.x, paddle2.y, paddle2.width, paddle2.height)

  drawNet()
  drawScores()
end

function love.keypressed(key, scancode)
  if scancode == 'w' then
    paddle1.direction = 'up'
  elseif scancode == 's' then
    paddle1.direction = 'down'
  end
end

function love.keyreleased(key, scancode)
  if scancode == 'w' or scancode == 's' then
    paddle1.direction = nil
  end
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

function moveAIPaddle(dt)
  local middleOfBall = ball.y + (ball.height / 2)
  local middleOfPlayer2Paddle = paddle2.y + (paddle2.height / 2)
  local distanceDelta = math.abs(middleOfPlayer2Paddle - middleOfBall)
  local movement = math.min(distanceDelta, paddle2.speed * dt)
  local randomNum = math.random()

  if randomNum > 0.35 then
    if middleOfBall > middleOfPlayer2Paddle and paddle2.y + paddle2.height < 600 then
      paddle2.y = paddle2.y + movement
    elseif middleOfBall < middleOfPlayer2Paddle and paddle2.y > 0 then
      paddle2.y = paddle2.y - movement
    end
  end
end

function playerScores(player)
  score[player] = score[player] + 1
end

function resetBall ()
  local movement

  if not gameStarted then
    movement = 200
  else
    movement = ball.speedX
  end

  return {
    x = 395,
    y = 295,
    width = 10,
    height = 10,
    color = {255, 255, 255},
    speedX = movement,
    speedY = movement
  }
end

function increaseDifficulty()
  local speedToIncreaseX = ball.speedX / math.abs(ball.speedX)
  local speedToIncreaseY = ball.speedY / math.abs(ball.speedY)
  ball.speedX = ball.speedX + (speedToIncreaseX * 50)
  ball.speedY = ball.speedY + (speedToIncreaseY * 50)
end
