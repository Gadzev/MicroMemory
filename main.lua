local card = require('./src/card')

local background = nil
local cursor

function love.load()
	background = love.graphics.newImage('assets/background.jpg')
	-- TODO: Change cursor image
	cursor = love.mouse.newCursor('assets/cursor.png', 0, 0)
	love.mouse.setCursor(cursor) 
	card.loadAssets()
end

function love.update() 

end

function love.draw() 
	love.graphics.draw(background, 0, 0)
	--card.draw()
	card.drawCards()
end
