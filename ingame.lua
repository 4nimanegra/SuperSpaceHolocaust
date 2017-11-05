local Ingame={}
Player=require "player"
Grid=require "grid"

local width;
local height;

local transx;
local transy;


function Ingame.load()

	width=realwidth;
	height=realheight;

	transx=0;
	transy=0;

	MAXDELAY=100;

	music = love.audio.newSource("music/ingame.ogg");

	ready = love.audio.newSource("sound/ready.ogg");
	go = love.audio.newSource("sound/go.ogg");
	completed=love.audio.newSource("sound/mission_completed.ogg");

	initx=width/2;
	inity=height/2;

	puntostotales=0;
	nivel=3;
	puntos=nivel;

	math.randomseed(os.time());
	player=Player.load(initx,inity);
	grid=Grid.load(nivel+2);

	delay=MAXDELAY;

	delaywin=0

	delaydie=0;

	gamerotation=0;

end

function Ingame.keypressed(key)

	if delay == 0 then

		player.keypressed(key);

	end

end

function Ingame.update()

	music:play();

	if player.die == 1 then

		if delaydie== 0 then

			delaydie=MAXDELAY;

		end

		delaydie=delaydie-1;

		if delaydie==1 then

			music:stop();

			return -1;

		end

	end	

	if delay == 0 then

		if puntos > 0 then

			player.update();
			grid.update();
		else

			nivel=nivel+1;
			puntos=nivel;

			player=Player.load(initx,inity);
			grid=Grid.load(nivel+2);

			transx=0;
			transy=0;

			delaywin=MAXDELAY;
			delay=-1;

			if nivel > 5 then

				player.adv=3;

			end

			if nivel > 8 then

				player.adv=4;

			end

			if nivel > 12 then
				
				anglesum=0.01;

				gamerotation=1;

			end

		end

	else

		if delay > 0 then

			if delay == MAXDELAY then

				ready:play();

			elseif delay == 20 then

				go:play();

			end

			delay=delay-1;

		end

		if delaywin > 0 then

			if delaywin == MAXDELAY then
	
				completed:play();

			end

			delaywin=delaywin-1;

		end


	end

end

function Ingame.rotate()

	if player.x > transx+width-width/3 then

		transx=player.x-width+width/3;

	end

	if player.x < transx+width/3 then

		transx=player.x-width/3;

	end

	if player.y > transy+height-height/3 then

		transy=player.y-height+height/3;

	end

	if player.y < transy+height/3 then

		transy=player.y-height/3;

	end

	if gamerotation == 1 then

		if angle==nil then

			angle=0;
			timing=400;

		end

		if timing == -400 then

			timing=400;

			if anglesum < 0.2 then

				anglesum=anglesum+0.01;

			end

		end

		timing=timing-1;

		if timing > 0 then

			angle=angle+anglesum;

		else

			angle=angle-anglesum;	

		end

		love.graphics.translate(width/2, height/2)
		love.graphics.rotate(angle)
		love.graphics.translate(-width/2, -height/2)

	end

	if player.die == 0 then

		love.graphics.translate(-transx, -transy);

	end

end

function Ingame.draw()

	local text;

	love.graphics.setLineWidth(3);
	love.graphics.setLineStyle("rough");

	love.graphics.push();

		Ingame.rotate();

		grid.draw();

		player.draw();

	love.graphics.pop();

	love.graphics.setFont(font);

	love.graphics.setColor(0,255,0);

	if nivel-2 < 10 then

		text="Level: 0"..nivel-2;

	else

		text="Level: "..nivel-2;

	end

	love.graphics.rectangle("line",10,10,230,50);

	love.graphics.print(text, 15, 15,0,1,1);

	if delay > 20 then

		love.graphics.print("Get ready...", width/20, height/3,0,2,2);

	elseif delay > 0 then

		love.graphics.print("Go!!", width/4, height/3,0,3,3);

	end


	if delaywin ~= 0 then

		love.graphics.print("Completed!!!", width/40, height/3,0,2,2);

		if delaywin == 1 then

			delay=MAXDELAY;

		end

	end

end

return Ingame;
