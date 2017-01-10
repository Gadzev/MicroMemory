Gamestate = require('./libraries/gamestate')

game = require ('./src/game')

local menu = {}

function menu:draw()
	love.graphics.print("Press enter to continue", 10, 10)
end

function menu:keyreleased(key, code)
	if key == 'return' then
		Gamestate.switch(game)
	end
end

return menu