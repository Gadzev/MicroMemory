local card = require('./src/card')
local cards = card.getCards()

local background = nil
local cursor

local counter = 0
local cardTimer = 0

function love.load()
	background = love.graphics.newImage('assets/background.jpg')
	-- TODO: Change cursor image
	cursor = love.mouse.newCursor('assets/cursor.png', 0, 0)
	love.mouse.setCursor(cursor) 
	card.loadAssets()
end

function love.update(dt) 
	if counter == 2 then
		cardTimer = cardTimer + dt
		print("cardTimer: ", cardTimer)
	end
	if cardTimer > 0.9 then
		for i, card in ipairs(cards) do
			card.cardBack = love.graphics.newImage('assets/card-back.png')
		end
		cardTimer = 0
		counter = 0
	end
end

function love.draw() 
	love.graphics.draw(background, 0, 0)
	--card.draw()
	card.drawCards()
end

function love.mousepressed(x, y, button, istouch)
	print(counter)
	if button == 1 then
		for i, card in ipairs(cards) do
			if x >= card.x and x < card.x + card.width
			and y >= card.y and y < card.y + card.height
			and counter ~= 2 then
				card.cardBack = love.graphics.newImage(card.cardFace)
				counter = counter + 1
				--print(card.cardFace)
			end
		end
	end
end
