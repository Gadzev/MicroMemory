Gamestate = require('./libraries/gamestate')
suit = require('./libraries/SUIT/')

game = require ('./src/game')

local menu = {}

function menu:enter()
	title = love.graphics.newImage('assets/title.png')
	image = love.graphics.newImage('assets/Play.png')
	imageHovered = love.graphics.newImage('assets/Play-hover.png')
	quit = love.graphics.newImage('assets/quit.png')
	quitHovered = love.graphics.newImage('assets/quit-hover.png')
	web = love.graphics.newImage('assets/web.png')
	webHovered =  love.graphics.newImage('assets/web-hover.png')

	-- TODO: Change font
	font = love.graphics.newFont('assets/CaviarDreams.ttf', 60)

	suit.theme.color.normal.bg = {214, 76, 77}
	suit.theme.color.normal.fg = {54, 71, 79}
end

function menu:draw()
	love.graphics.draw(title, 380, 124)
	suit.draw()
end

function menu:update(dt)
	if suit.ImageButton(image, {hovered = imageHovered}, 462, 420).hit then
		Gamestate.switch(game)
	elseif suit.ImageButton(quit, {hovered = quitHovered}, 520, 550).hit then
		love.event.quit()
	elseif suit.ImageButton(web, {hovered = webHovered}, 420, 550).hit then
		love.system.openURL("https://github.com/Gadzev/MicroMemory")
	end
end

return menu