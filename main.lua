Gamestate = require('./libraries/gamestate')
menu = require('./src/menu')

local background = nil
local cursor

function love.load()
	background = love.graphics.newImage('assets/background.jpg')
	music = love.audio.newSource('assets/music.mp3')
	music:setLooping(true)
	music:play()
	-- TODO: Change cursor image
	cursor = love.mouse.newCursor('assets/cursor.png', 0, 0)
	love.mouse.setCursor(cursor) 
	Gamestate.registerEvents()
	Gamestate.switch(menu)
end

function love.update(dt) 
	
end

function love.draw() 
	love.graphics.draw(background, 0, 0)
end
