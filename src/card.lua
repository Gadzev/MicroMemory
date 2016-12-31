local CARDS_HORIZONTAL = 4
local CARDS_VERTICAL = 3
local MAX_CARDS = 15
local INITIAL_X = 30
local INITIAL_Y = 30

local card = {
	x = INITIAL_X,
	y = INITIAL_Y,
	img = nil	
};

local cards = {}

function cards.create(card)
	for i = 1, MAX_CARDS do
		table.insert(cards, card)
	end
end

function card.loadAssets()
	card.img = love.graphics.newImage('assets/card-back.png');
	cards.create(card) 
end

function card.draw() 
	love.graphics.draw(card.img, card.x, card.y)
	love.graphics.print(table.getn(cards), 300, 200)
end

function card.drawCards()
	local countHorizontal = 0
	-- Adjust the space between the cards
	local spaceX = 64
	local spaceY = 74
	-- Iterate through all the cards and draw them on the table
	for i, card in ipairs(cards) do
		if countHorizontal < CARDS_HORIZONTAL then
			love.graphics.draw(cards[i].img, cards[i].x + spaceX, cards[i].y + spaceY)
			spaceX = spaceX + 64
			countHorizontal = countHorizontal + 1
		else
			love.graphics.draw(cards[i].img, cards[i].x, cards[i].y + spaceY)
			spaceY = spaceY + 74
			countHorizontal = 0
			spaceX = 64
		end
	end
end

return card