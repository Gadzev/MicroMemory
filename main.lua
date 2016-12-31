local card = require('./src/card')

function love.load() 
	card.loadAssets()
end

function love.update() 

end

function love.draw() 
	card.draw()
end
