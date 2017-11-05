Corner={}

function Corner.load(xin,yin)

	local self = {}

	self.x=xin;
	self.y=yin;

	self.radius=10;

	self.die=0;
	self.explode=255;

	function self.update()

		if self.x == player.x and self.y == player.y and player.explode == 256 then

			if player.change ~= 1 then

				player.change=1;

			end

			self.die=1;

		end

	end

	function self.draw()

		if self.die == 0 then 

			love.graphics.setColor(0,150,0);

		else

			if self.explode > 0 then

				self.explode=self.explode-10;

				love.graphics.setColor(0,150,0,self.explode);

				self.radius=self.radius+10;

			end
			

		end

		love.graphics.circle("fill",self.x,self.y,self.radius);

		if self.die == 0 then 

			love.graphics.setColor(0,100,0);

		else

			love.graphics.setColor(0,100,0,self.explode);

		end

		love.graphics.circle("line",self.x,self.y,self.radius);


	end

	return self;

end

return Corner;
