local card = require('./src/card')

local background = nil

function love.load()
	background = love.graphics.newImage('assets/background.jpg') 
	card.loadAssets()
end

function love.update() 

end

function love.draw() 
	love.graphics.draw(background, 0, 0)
	--card.draw()
	card.drawCards()
end
