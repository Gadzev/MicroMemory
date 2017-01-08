local _ = require 'moses_min'

local CARDS_HORIZONTAL = 3
-- local CARDS_VERTICAL = 3
local MAX_CARDS = 12
local INITIAL_X = 64
local INITIAL_Y = 74

local images = {
	'assets/1.png',
	'assets/2.png',
	'assets/3.png',
	'assets/4.png',
	'assets/5.png',
	'assets/card-back-1.png'
}

local card = {
	x = INITIAL_X,
	y = INITIAL_Y,
	cardBack = nil,
	cardFace = nil,
	width = 48,
	height = 64
};

local cards = {}

-- Create the cards table, fill the cards with random images and then shuffle the table
function card.create(card)
	for i = 1, MAX_CARDS / 2 do
		local rng = love.math.newRandomGenerator()
		local r = rng:random(1, #images)
		table.insert(cards, {x = card.x, y = card.y, cardBack = card.cardBack,
							 cardFace = images[r], width = card.width, height = card.height})
		table.insert(cards, {x = card.x, y = card.y, cardBack = card.cardBack,
							 cardFace = images[r], width = card.width, height = card.height})
		table.remove(images, r)
	end
	cards = _.shuffle(cards, os.time())
end

function card.loadAssets()
	card.cardBack = love.graphics.newImage('assets/card-back.png');
	card.create(card)
end

function card.draw() 
	love.graphics.draw(card.cardBack, card.x, card.y)
	--love.graphics.print(table.getn(cards), 300, 200)
end

function card.drawCards()
	local countHorizontal = 0
	-- Adjust the space between the cards
	local spaceX = 64
	local spaceY = 74
	-- Iterate through all the cards and draw them on the table
	for i, card in ipairs(cards) do
		if countHorizontal < CARDS_HORIZONTAL then
			love.graphics.draw(card.cardBack, card.x, card.y)
			spaceX = spaceX + 64
			card.x = spaceX
			card.y = spaceY
			countHorizontal = countHorizontal + 1
		else
			love.graphics.draw(card.cardBack, card.x, card.y)
			card.y = spaceY
			spaceY = spaceY + 74
			countHorizontal = 0
			spaceX = 64
		end
	end
end

function card.getCards() 
	return cards
end

return card
