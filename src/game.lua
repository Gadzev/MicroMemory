Gamestate = require('./libraries/gamestate')
suit = require('./libraries/SUIT/')

local card = require('./src/card')
local cards = card.getCards()

local counter = 0
local cardTimer = 0
local gameTimer = 30
local prevCard = {}
local prevIndex = 0
local score = 0
local gameOver = false
local fadeOut = 255
local winCondition = 0

game = {}

function game:enter()
	font = love.graphics.newFont('assets/CaviarDreams.ttf', 60)
	card.loadAssets()
	fontColor = {normal = {bg = {255,255,255}, fg = {255,255,255}}}
end

function game:update(dt)
	if gameOver == false then
		suit.Label(score, {font = font, color = fontColor}, 1, 1, 200, 100)
		suit.Label(gameTimer, {font = font, color = fontColor}, 750, 1, 200, 100)
	else
		game:gameover(dt)
	end

	gameTimer = string.format("%.02f", gameTimer - dt)

	if gameTimer < '0' then
		gameOver = true
	elseif winCondition == 6 then
		gameOver = true
		game:gameover(dt)
	end

	if counter == 2 then
		cardTimer = cardTimer + dt
		prevCard = {}
	end
	if cardTimer > 0.9 then
		for i, card in ipairs(cards) do
			if card.match == false then
				card.cardBack = love.graphics.newImage('assets/card-back-1-1.png')
			end
		end
		cardTimer = 0
		counter = 0
	end
end

function game:draw()
	suit.draw()
	card.drawCards()
	--card.draw()
end

function game:mousepressed(x, y, button, istouch)
	for i, card in ipairs(cards) do
			if button == 1 and card.match ~= true and gameOver ~= true then
				if x >= card.x and x < card.x + card.width
				and y >= card.y and y < card.y + card.height
				and counter ~= 2 then
					card.cardBack = love.graphics.newImage(card.cardFace)
					if prevCard.cardFace == card.cardFace and prevCard ~= card then
						print('Match!')
						winCondition = winCondition + 1
						print(winCondition)
						score = score + 100
						card.match = true
						cards[prevIndex].match = true
						counter = counter + 1
					end
					if prevCard ~= card and card.match ~= true then
						counter = counter + 1
					end
					prevCard = card
					prevIndex = i
			end
		end
	end
end

function game:gameover(dt)
	fadeOut = fadeOut - dt * 50

	love.graphics.setColor(255, 255, 255, fadeOut)
	if fadeOut < 10 then
		suit.Label("Game Over", {font = font, color = fontColor}, 410, 240, 200, 200)
	end

	if fadeOut < -20 then
		suit.Label("Score: "..score, {font = font, color = fontColor}, 380, 400, 300, 300)
	end
end

return game