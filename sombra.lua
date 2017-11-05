local Sombra={}
function Sombra.load(sombra)

	local self = {}
	self.x=player.x;
	self.y=player.y;
	
	if sombra ~= nil then

		self.sombra=sombra;

	end

	self.radio=player.radio;

	self.explode=256;

	function self.draw()

		if self.explode > 0 then
			
			if self.sombra ~= nil then

				self.sombra.draw();

			end

			if self.explode > 0 then

				self.explode=self.explode-10;

			end

			love.graphics.setColor(0,100,0,self.explode);

			love.graphics.circle("fill",self.x,self.y,self.radio);

			love.graphics.setColor(0,50,0,self.explode);

			love.graphics.circle("line",self.x,self.y,self.radio);

		else

			self.sombra=nil;

		end

	end
	return self;
end

return Sombra;
