Sombra = require "sombra"

local Player={}
function Player.load(xin,yin)

	local self = {}
	self.x=xin;
	self.y=yin;

	self.radio=20;
	self.dir=0;
	self.dir2=self.dir;

	self.change=0;

	self.die=0;
	self.explode=256;

	self.adv=2;

	function self.keypressed(key)
		if key == "right" then

			self.dir2=(self.dir+4-1)%4;

		elseif key == "left" then

			self.dir2=(self.dir+1)%4;

		end

	end

	function self.update()

		if self.die == 1 then

			if self.explode == 256 then

				self.explode=255;

			end

		end

			if self.change == 1 then

				self.change=0;

				self.dir=self.dir2;

			end

			self.sombra=Sombra.load(self.sombra);

			if self.dir==0 then

				self.x=self.x+self.adv;

			elseif self.dir == 1 then

				self.y=self.y-self.adv;

			elseif self.dir == 2 then

				self.x=self.x-self.adv;

			elseif self.dir == 3 then

				self.y=self.y+self.adv;

			end

			self.die=1;


	end

	function self.draw()

		if self.sombra ~= nil then

			self.sombra.draw();

		end

		if self.explode==256 then

			love.graphics.setColor(0,100,0);

		else

			if self.explode > 0 then

				self.explode=self.explode-10;

			end

			love.graphics.setColor(0,100,0,self.explode);

			if self.radio > 0 then

				self.radio=self.radio - 1;

			end

		end

		love.graphics.circle("fill",self.x,self.y,self.radio);

		if self.explode==256 then

			love.graphics.setColor(0,50,0);

		else

			love.graphics.setColor(0,50,0,self.explode);

		end

		love.graphics.circle("line",self.x,self.y,self.radio);


	end
	return self;
end

return Player;
