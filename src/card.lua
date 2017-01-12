local _ = require('./libraries/moses_min')

local CARDS_HORIZONTAL = 3
-- local CARDS_VERTICAL = 3
local MAX_CARDS = 12
local INITIAL_X = 178
local INITIAL_Y = 188

local images = {
	'assets/1-1.png',
	'assets/1-2.png',
	'assets/1-3.png',
	'assets/1-4.png',
	'assets/1-5.png',
	'assets/1-6.png'
}

local card = {
	x = INITIAL_X,
	y = INITIAL_Y,
	cardBack = nil,
	cardFace = nil,
	width = 124,
	height = 178,
	match = false
};

local cards = {}

-- Create the cards table, fill the cards with random images and then shuffle the table
function card.create(card)
	for i = 1, MAX_CARDS / 2 do
		local rng = love.math.newRandomGenerator()
		local r = rng:random(1, #images)
		table.insert(cards, {x = card.x, y = card.y, cardBack = card.cardBack,
							 cardFace = images[r], width = card.width, height = card.height, match = card.match})
		table.insert(cards, {x = card.x, y = card.y, cardBack = card.cardBack,
							 cardFace = images[r], width = card.width, height = card.height, match = card.match})
		table.remove(images, r)
	end
	cards = _.shuffle(cards, os.time())
end

function card.loadAssets()
	card.cardBack = love.graphics.newImage('assets/card-back-1-1.png');
	card.create(card)
end

function card.draw() 
	love.graphics.draw(card.cardBack, card.x, card.y)
	--love.graphics.print(table.getn(cards), 300, 200)
end

function card.drawCards()
	local countHorizontal = 0
	-- Adjust the space between the cards
	local spaceX = 178
	local spaceY = 188
	-- Iterate through all the cards and draw them on the table
	for i, card in ipairs(cards) do
		if countHorizontal < CARDS_HORIZONTAL then
			love.graphics.draw(card.cardBack, card.x, card.y)
			spaceX = spaceX + 178
			card.x = spaceX
			card.y = spaceY
			countHorizontal = countHorizontal + 1
		else
			love.graphics.draw(card.cardBack, card.x, card.y)
			card.y = spaceY
			spaceY = spaceY + 188
			countHorizontal = 0
			spaceX = 178
		end
	end
end

function card.getCards() 
	return cards
end

return card
