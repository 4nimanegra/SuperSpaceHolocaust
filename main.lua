Ingame = require "ingame";
Menu=require "menu";
Score=require "score";
local screen;

realwidth=640;
realheight=480;

function love.load()

	screen=0;

	--love.window.setMode(640,480,{fullscreen=true});
	love.window.setFullscreen(true);

	font=love.graphics.newFont("font/computer.ttf",35);

	Menu.load();

end

function love.touchpressed( id, x, y, dx, dy, pressure )

	if (x < love.graphics.getWidth()/2) then

		key="left";

	else

		key="right";

	end

	if screen == 0 then

		Menu.keypressed(key);

	elseif screen == 1 then

		Ingame.keypressed(key);

	elseif screen == 2 then

		Score.keypressed(key);

	end



end

function love.keypressed(key)

	if key=="escape" then

		love.event.quit();

	end

	if screen == 0 then

		Menu.keypressed(key);

	elseif screen == 1 then

		Ingame.keypressed(key);

	elseif screen == 2 then

		Score.keypressed(key);

	end

end

function love.update()

	local nextscreen;

	if screen == 0 then

		nextscreen = Menu.update();

		if nextscreen == -1 then

			screen = 1;

			Ingame.load();

		end

	elseif screen == 1 then

		nextscreen = Ingame.update();

		if nextscreen == -1 then

			screen = 2;

			Score.load();

		end

	elseif screen == 2 then

		nextscreen = Score.update();

		if nextscreen == -1 then

			screen = 0;

			Menu.load();

		end


	end

end

function love.draw()

	love.graphics.push();

	love.graphics.scale(love.graphics.getWidth()/realwidth, love.graphics.getHeight()/realheight);

	if screen == 0 then

		Menu.draw();

	elseif screen == 1 then

		Ingame.draw();

	elseif screen == 2 then

		Score.draw();

	end

	

	love.graphics.pop();

end
