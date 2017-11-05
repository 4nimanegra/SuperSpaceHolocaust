Score = {}
local socket = require "socket.http"
local screen;

local width;
local height

local hof;

local hofnumber;
local hoftime;

local position;

local word;

local waitingtime;

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

function Score.load()

	music = love.audio.newSource("music/menu.ogg");

	width=realwidth;
	height=realheight;

	screen=0;

	word="___";

	position=1;

	letter=string.byte("A",1);

	waitingtime=100;

end

function Score.keypressed(key)

	if key=="left" then

		letter=letter+1;

		if(letter > string.byte("Z",1)) then

			letter=string.byte("A",1);

		end

	elseif key == "right" then

		if position < 4 then

			word=word:sub(1, position-1) .. string.char(letter) .. word:sub(position+1)

			position=position+1;

		end

	end

	return 0;

end

function Score.update()

	if((position > 3) and (waitingtime==100))then

		socket.request("https://dollarone.games/elympics//submitHighscore?key=TransparentSleepyWoozle&name="..word.."&score="..nivel-2);

	end

	if((position > 3) and (waitingtime==0))then

		music:stop();

		return -1;

	end

	if position > 3 then

		waitingtime=waitingtime-1;

	end

	return screen;

end

function Score.draw()

	local table = {};
	local i;
	local fd;

	music:play();

	table[0]=255;
	table[1]=100;
	table[2]=50;

	i=0;

	while i < 4 do

		love.graphics.setColor(0,table[math.floor(math.random()*3)%3],0);

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

	love.graphics.setColor(0,255,0);

	love.graphics.setFont(font);

	love.graphics.print(string.char(letter),width/6,5.4*height/10,0,2,2);

	love.graphics.print("Select",width/2+width/12,5.5*height/10,0,1,1);	

	love.graphics.print("Hall of Fame",width/5,4*height/10,0,1.25,1.25);

	love.graphics.print(word,width/3+width/20,6*height/10,0,1.5,1.5);

end

return Score;
