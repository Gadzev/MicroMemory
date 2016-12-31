local card = {
	x = 300,
	y = 300,
	img = nil	
};

function card.loadAssets() 
	card.img = love.graphics.newImage('assets/card-back.png');
end

function card.draw() 
	love.graphics.draw(card.img, card.x, card.y)
end

return card