Menu = {}
local socket = require "socket.http"
local screen;

local width;
local height

local hof;

local hofnumber;
local hoftime;

function string.explode(str, div)
    assert(type(str) == "string" and type(div) == "string", "invalid arguments")
    local o = {}
    while true do
        local pos1,pos2 = str:find(div)
        if not pos1 then
            o[#o+1] = str
            break
        end
        o[#o+1],str = str:sub(1,pos1-1),str:sub(pos2+1)
    end
    return o
end

function Menu.load()

	music = love.audio.newSource("music/menu.ogg");

	width=realwidth;
	height=realheight;

	screen=0;

end

function Menu.keypressed(key)

	if key=="left" then

		screen=screen-1;

	elseif key == "right" then

		screen=screen+1;

	end

	if screen == -1 then

		music:stop();

	end

	if screen == 2 then

		love.event.quit();

	end

	return screen;

end

function Menu.update()

	return screen;

end

function compare(a,b)

	local auxa;
	local auxb;

	auxa=a:explode(",");
	auxb=b:explode(",");

	auxa=auxa[2];
	auxb=auxb[2];

	if(auxa~=nil) and (auxb~=nil)then

		return tonumber(auxa) > tonumber(auxb);

	else

		if (auxa~=nil) then

			return 5 > 1;

		else

			return 1 > 5;

		end	

	end


end

function Menu.draw()

	local tableR = {};
	local i;
	local fd;

	music:play();

	tableR[0]=255;
	tableR[1]=100;
	tableR[2]=50;

	i=0;

	while i < 4 do

		love.graphics.setColor(0,tableR[math.floor(math.random()*3)%3],0);

		love.graphics.rectangle("fill",i*10,i*10,width-i*20,height-i*20);

		i=i+1;

	end

	love.graphics.setColor(0,0,0);

	love.graphics.rectangle("fill",i*10,i*10,width-i*20,height-i*20);



	love.graphics.setColor(0,255,0);

	love.graphics.setFont(font);

	love.graphics.print("Super",width/4,height/10,0,2,1);
	love.graphics.print("Space",width/4,2*height/10,0,2,1);
	love.graphics.print("Holocaust",width/10,3*height/10,0,2,1);

	love.graphics.setLineWidth(10);
        love.graphics.setLineStyle("rough");

	love.graphics.setColor(0,50,0);

	love.graphics.polygon("fill",width/10,6*height/10,width/7,5*height/10,width/7,7*height/10);

	love.graphics.setColor(0,100,0);

	love.graphics.polygon("line",width/10,6*height/10,width/7,5*height/10,width/7,7*height/10);

	love.graphics.setColor(0,50,0);

	love.graphics.polygon("fill",width-width/10,6*height/10,width-width/7,5*height/10,width-width/7,7*height/10);

	love.graphics.setColor(0,100,0);

	love.graphics.polygon("line",width-width/10,6*height/10,width-width/7,5*height/10,width-width/7,7*height/10);

	if screen == 0 then

		love.graphics.setColor(0,255,0);

		love.graphics.setFont(font);

		love.graphics.print("New",width/6+30,5*height/10,0,1,1);
		love.graphics.print("Game",width/6+10,6*height/10,0,1,1);	

		love.graphics.print("Options",width/2,5.5*height/10,0,1,1);	

		hof=nil;

		hofnumber=0;
		hoftime=250;

	elseif screen==1 then

		local size;
		local fd;

		if hof == nil then

			b, c, h=socket.request("https://dollarone.games/elympics/getHighscores?gamename=superspaceholocaust&format=txt&unique=true");

			if(b ~= nil)then

				hof=b:explode("\n");

				table.sort(hof,compare);

			end

			if hof[9] == nil then
	
				size = love.filesystem.getSize("data/hof.dat");

				fd = love.filesystem.read( "data/hof.dat", size );

				hof=fd:explode("\n");

			end

		end

		love.graphics.setColor(0,255,0);

		love.graphics.setFont(font);

		love.graphics.print("Back",width/6,5.5*height/10,0,1,1);

		love.graphics.print("Exit",width/2+width/6,5.5*height/10,0,1,1);	

		love.graphics.print("Hall of Fame",width/5,4*height/10,0,1.25,1.25);

		love.graphics.setColor(0,255,0,hoftime);

		aux=hof[hofnumber+1]:explode(",");

		love.graphics.print(""..(hofnumber+1).." "..aux[1].." "..aux[2],width/3+width/20,6*height/10,0,0.75,0.75);

		hoftime=hoftime-5;

		if hoftime == 0 then

			hofnumber=((hofnumber+1)%9);

			hoftime=255;

		end

	end

end

return Menu;
