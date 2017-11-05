Corner = require "corner"
Rectangle={}

function Rectangle.load(xin,yin)

	local self = {}

	self.height=120;
	self.width=120;

	self.x=xin*self.width-(50*self.width)+initx;
	self.y=yin*self.height-(50*self.height)+inity;

	self.explode=256;

	self.die=0;

	self.corner1=Corner.load(self.x,self.y);
	self.corner2=Corner.load(self.x+self.width,self.y);
	self.corner3=Corner.load(self.x+self.width,self.y+self.height);
	self.corner4=Corner.load(self.x,self.y+self.height);

	function self.update()

		local noplayer;

		if self.explode == 256 then

			self.corner1.update();
			self.corner2.update();
			self.corner3.update();
			self.corner4.update();

			if self.die ~= 1 and self.corner1.die == 1 and self.corner2.die == 1 and self.corner3.die == 1 and self.corner4.die == 1 then

				puntos=puntos-1;
				puntostotales=puntostotales+1;

				self.die=1;

			end

			noplayer=true;

			if player.x == self.x or player.x == self.x+self.width then

				if player.y >= self.y and player.y <= self.y+self.height then

					player.die=0;
					noplayer=false;

				end

			end

			if player.y == self.y or player.y == self.y+self.height then

				if player.x >= self.x and player.x <= self.x+self.width then

					player.die=0;
					noplayer=false;

				end

			end

			if noplayer and self.die == 1 then

				self.explode=255;

			end

		else


			self.explode=self.explode-10;

		end

	end

	function self.draw()

		love.graphics.setColor(0,255,0,self.explode);

		love.graphics.rectangle("line",self.x,self.y,self.width,self.height);

		if self.corner1.explode > 0 then

			self.corner1.draw();

		end

		
		if self.corner2.explode > 0 then

			self.corner2.draw();

		end

		if self.corner3.explode > 0 then

			self.corner3.draw();

		end

		if self.corner4.explode > 0 then

			self.corner4.draw();

		end

	end

	return self;

end

return Rectangle;
