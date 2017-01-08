local card = require('./src/card')
local cards = card.getCards()

local background = nil
local cursor

function love.load()
	background = love.graphics.newImage('assets/background.jpg')
	-- TODO: Change cursor image
	cursor = love.mouse.newCursor('assets/cursor.png', 0, 0)
	love.mouse.setCursor(cursor) 
	card.loadAssets()
end

function love.update(dt) 

end

function love.draw() 
	love.graphics.draw(background, 0, 0)
	--card.draw()
	card.drawCards()
end

function love.mousepressed(x, y, button, istouch)
	if button == 1 then
		for i, card in ipairs(cards) do
			if x >= card.x and x < card.x + card.width
			and y >= card.y and y < card.y + card.height then
				card.cardBack = love.graphics.newImage(card.cardFace)
			end
		end
	end
end
