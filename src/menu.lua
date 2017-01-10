Gamestate = require('../gamestate')

local menu = {}

function menu:draw()
	love.graphics.print("Press enter to continue", 10, 10)
end

function menu:keyreleased(key, code)
	if key == 'return' then
		Gamestate.switch(main)
	end
end

return menu