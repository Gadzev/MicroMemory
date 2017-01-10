Gamestate = require('./libraries/gamestate')

local card = require('./src/card')
local cards = card.getCards()

local counter = 0
local cardTimer = 0
local prevCard = {}
local prevIndex = 0

game = {}

function game:enter()
	card.loadAssets()
end

function game:update(dt)
	if counter == 2 then
		cardTimer = cardTimer + dt
		prevCard = {}
		--print("cardTimer: ", cardTimer)
	end
	if cardTimer > 0.9 then
		for i, card in ipairs(cards) do
			if card.match == false then
				card.cardBack = love.graphics.newImage('assets/card-back.png')
			end
		end
		cardTimer = 0
		counter = 0
	end
end

function game:draw()
	card.drawCards()
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