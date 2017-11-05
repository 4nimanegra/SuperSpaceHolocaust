Rectangle = require "rectangle";
local Grid={};

function Grid.load(level)

	local self={};
	local i,ii;
	local pos;
	local matrix;

	self.width=100;
	self.height=100;

	self.level=level;

	i=1;

	self.matrix={};

	while(i<self.height)do

		self.matrix[i]={}

		ii=1;

		while(ii<self.height)do

			self.matrix[i][ii]=0;

			ii=ii+1;

		end

		i=i+1;

	end

	self.squares={};

	table.insert(self.squares,{50,50});
	self.matrix[50][50]=1;

	i=1;

	while(i<self.level)do

		pos = self.squares[math.random(table.getn(self.squares))];

		ii=math.random(4);

		if(ii == 1)then

			if self.matrix[math.min(pos[1]+1,self.width)][pos[2]]==0 then

				self.matrix[math.min(pos[1]+1,self.width)][pos[2]]=1;

				table.insert(self.squares,{math.min(pos[1]+1,self.width),pos[2]});

				i=i+1;

			end

		elseif ii == 2 then
			if self.matrix[math.max(pos[1]-1,1)][pos[2]]==0 then

				self.matrix[math.max(pos[1]-1,1)][pos[2]]=1;

				table.insert(self.squares,{math.max(pos[1]-1,1),pos[2]});

				i=i+1;

			end


		elseif ii == 3 then
			if self.matrix[pos[1]][math.min(pos[2]+1,self.height)]==0 then

				self.matrix[pos[1]][math.min(pos[2]+1,self.height)]=1;

				table.insert(self.squares,{pos[1],math.min(pos[2]+1,self.height)});

				i=i+1;

			end


		else
			if self.matrix[pos[1]][math.max(pos[2]-1,1)]==0 then

				self.matrix[pos[1]][math.max(pos[2]-1,1)]=1;

				table.insert(self.squares,{pos[1],math.max(pos[2]-1,1)});

				i=i+1;

			end


		end


	end

	self.ground={};

	i=1;

	while i < table.getn(self.squares) do
		
		table.insert(self.ground,Rectangle.load(self.squares[i][1],self.squares[i][2]));
			
		i=i+1;

	end

	function self.update()

		local i;

		i=1;

		while i < table.getn(self.ground) do

			(self.ground[i]).update();

			i=i+1;

		end


	end

	function self.draw()

		local i;

		i=1;

		love.graphics.setColor(0,255,0);

		while i < table.getn(self.ground) do

			(self.ground[i]).draw();

			i=i+1;

		end

	end


	return self;

end

return Grid;
