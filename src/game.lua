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

function game:enter(previous)
	matchSound = love.audio.newSource('assets/match.mp3')
	font = love.graphics.newFont('assets/CaviarDreams.ttf', 60)
	smallFont = love.graphics.newFont('assets/CaviarDreams.ttf', 15)
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
end

-- When the left mouse button is pressed, we flip the card to its face position and check for a match
function game:mousepressed(x, y, button, istouch)
	for i, card in ipairs(cards) do
			if button == 1 and card.match ~= true and gameOver ~= true then
				if x >= card.x and x < card.x + card.width
				and y >= card.y and y < card.y + card.height
				and counter ~= 2 then
					card.cardBack = love.graphics.newImage(card.cardFace)
					if prevCard.cardFace == card.cardFace and prevCard ~= card then
						matchSound:play()
						winCondition = winCondition + 1
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

	if winCondition == 6 then
		str = "You Won!"
	else
		str = "Game Over"
	end

	love.graphics.setColor(255, 255, 255, fadeOut)
	if fadeOut < 10 then
		suit.Label(str, {font = font, color = fontColor}, 410, 240, 200, 200)
	end

	if fadeOut < -20 then
		suit.Label("Score: "..score, {font = font, color = fontColor}, 370, 400, 320, 320)
		suit.Label("Press escape to restart the game...", {font = smallFont, color = fontColor}, 410, 700)
	end

	if love.keyboard.isDown("escape") then
		love.event.quit('restart') 
	end

end

return game