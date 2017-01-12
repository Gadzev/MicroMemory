Gamestate = require('./libraries/gamestate')
suit = require('./libraries/SUIT/')

local card = require('./src/card')
local cards = card.getCards()

local counter = 0
local cardTimer = 0
local gameTimer = 60
local prevCard = {}
local prevIndex = 0
local score = 0

game = {}

function game:enter()
	font = love.graphics.newFont('assets/CaviarDreams.ttf', 60)
	card.loadAssets()
	fontColor = {normal = {bg = {255,255,255}, fg = {255,255,255}}}
end

function game:update(dt)
	suit.Label(score, {font = font, color = fontColor}, 1, 1, 200, 100)
	suit.Label(gameTimer, {font = font, color = fontColor}, 750, 1, 200, 100)

	gameTimer = string.format("%.02f", gameTimer - dt)

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
			if button == 1 and card.match ~= true then
				if x >= card.x and x < card.x + card.width
				and y >= card.y and y < card.y + card.height
				and counter ~= 2 then
					card.cardBack = love.graphics.newImage(card.cardFace)
					if prevCard.cardFace == card.cardFace and prevCard ~= card then
						print('Match!')
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

return game