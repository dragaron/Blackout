---------------------------------------------------------------------------------------------------
--Blackout, by dragaron----------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------
--INITIALIZATION START-----------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
	--Setup directory
	if files.exists("samples/blackout.lua") then
	dir = "samples/blackout/"
	else
	dir = "resources/"
	end

	--Read from, or create if nonexistent, "config.ini" file
	if files.exists(dir .. "config.ini") then
	current_puzzle = tonumber(ini.read(dir .. "config.ini", "current_puzzle", 1))
	puzzle_record = {}
		for i = 1, 50 do
		puzzle_record[i] = tonumber(ini.read(dir .. "config.ini", "puzzle_record[" .. i .. "]", 999))
		end
	show_solution = tonumber(ini.read(dir .. "config.ini", "show_solution", 0))
	else
	ini.write(dir .. "config.ini", "current_puzzle", 1)
	current_puzzle = tonumber(ini.read(dir .. "config.ini", "current_puzzle", 1))
	puzzle_record = {}
		for i = 1, 50 do
		puzzle_record[i] = 999
		ini.write(dir .. "config.ini", "puzzle_record[" .. i .. "]", puzzle_record[i])
		end
	ini.write(dir .. "config.ini", "show_solution", 0)
	show_solution = tonumber(ini.read(dir .. "config.ini", "show_solution", 0))
	end


--COLORS-------------------------------------------------------------------------------------------
col_bg = color.new(0, 0, 0, 255)
col_fg = color.new(255, 255, 255, 40)
col_fg_lighter = color.new(255, 255, 255, 20)
col_outline = color.new(255, 255, 255, 80)
col_light_bg = color.new(0, 100, 0, 110)
col_light = color.new(255, 255, 255, 255)
col_solution = color.new(255, 255, 0, 255)


--FONTS--------------------------------------------------------------------------------------------
BAUHS93 = font.load(dir .. "BAUHS93.TTF")


--VFX----------------------------------------------------------------------------------------------


--SFX----------------------------------------------------------------------------------------------
sfx_switch = sound.load(dir .. "sfx_switch.mp3")


--BOOLEONS-----------------------------------------------------------------------------------------


--VARIABLES----------------------------------------------------------------------------------------
moves = 0


--TABLES-------------------------------------------------------------------------------------------
button = {"up", "down", "left", "right", "triangle", "cross", "square", "circle", "l", "r", "select", "start", "home", "volup", "voldown"}
puzzle = {
"1101100000110110000011011",
"1111100100000000010011111",
"1111101010001000101011111",
"0101010001000001101110001",
"0010001100110110011000100",
"0101011111101011111101010",
"1010110001110111000110101",
"0000000000011100100000000",
"0000100010001000110010100",
"0000010101100011010110001",
"1111101110011100111011111",
"1000101010000000101010001",
"0111001010011100001001110",
"1111010010111101110010010",
"1010110101101011010101110",
"0111001000011100001001110",
"1111110001101011000111111",
"1010100000101010000010101",
"0101010101011101010101010",
"1010100000000000000010101",
"1111110111110111110111111",
"1111100100111111000110001",
"1101101010110110101011011",
"0010001010111111000111111",
"1000111011101011000110001",
"1111110101111111010111111",
"0111000100001000010001110",
"0111001010111110111011011",
"0000000000001000000000000",
"1000100000001000000010001",
"1101111011000001101111011",
"0101000000100010111000100",
"1010101110110110111010101",
"1000111001101011001110001",
"1010110101110111010110101",
"0010000100011101010110101",
"1010110101101011010111111",
"0000001110011100111000000",
"0010001010100011111110001",
"1010101010101010101010101",
"1000101110010100111010001",
"0010001010100010101000100",
"1010100000010100000010101",
"0101011111010101111101010",
"1111110101111111011111111",
"1000101010001000101010001",
"1111100100111110010011111",
"1111101110001000111011111",
"0010010101111111010100100",
"1111111111111111111111111",
}
solution = {
".X.X.......X.X.......X.X.",
".X.X...X.........X...X.X.",
".X..X........XX......X..X",
".X.X.X...X.....X...X.....",
".X...XX...........XX...X.",
"..X....X..X.X.X..X....X..",
".....X.X.X..X.......X.X.X",
"X.XXXX..X..X.............",
"..XX..X...XX....X....X...",
"..........X.X.X..X...XXX.",
"..X..X...XX...X..X..X...X",
"X...X.X.X.......X.X.X...X",
"..XX...XXX..XX........X..",
".X.XX..XX.X..........XX..",
"X...X.XXX.X...X.......X..",
"...X..X..XX.X.XX..X..X...",
".X.X...X..X.X.X..X...X.X.",
".....X.X.XX.X.XX.X.X.....",
".X.X.X...X..X..X...X.X.X.",
"X.X.X.....X.X.XX.X.X.....",
".X......XXXX.XXXX......X.",
".X..X......XX.X.XXX..X..X",
".....XX.XX.X.X.XX.XX.....",
".X..XXX.XX...XX.....X..X.",
".X.X..X.X..X.X...X..X.X.X",
".X..X.....XXX..X.X.XXXX..",
".X..XX...XX.XX...X..XXX..",
".X..XX...XXX....X.X..XX.X",
"...XX..X...XX.XX...XX.XX.",
"...XXX.X.XX.XX......X.XX.",
".....XX.XXXX.XXXX.XX.....",
"..XXX.......XXXXX.XX.X..X",
".X.X..XXX.X...X.XXX..X.X.",
".XX.....XXX...X.XX.XX..XX",
".X.X..XXX..X.X..XXX..X.X.",
".X..XXX.XX.XX.X..X..X.XX.",
".X..X.X.X...XXXX.X.X..XXX",
".X.X.XX.XX..X..XX.XX.X.X.",
".X..XXX.XX...XX.XXX..X..X",
"X...X.XXX..XXX..XXX.X...X",
".X..X.XXX.X..X.XX.XXXXX..",
".X..XXX.XX...XX.XXX.XXX..",
".X..X.X.X.X..X.XXXXXXXX..",
"...XX.XXX..X..XXX.XXX.XX.",
"X......XXX.XXXX.XXX..XX.X",
".X..X.XXX.X.XX.XX.XXXXX..",
"...XXXX.XX..XXX.XXX.X.XX.",
"...XXXX.XX.XX.X.XXX.X.XX.",
".X..XXX.XXXXX...XXX.XXX..",
"...XXXX.XXXXX...XXX.X.XX.",
}


--FUNCTIONS----------------------------------------------------------------------------------------
function load_puzzle()
light = {}
	for i = 1, 25 do
	light[i] = string.sub(puzzle[current_puzzle], i, i)
	end
end


function light_switch(i)
	if i == 1 then
		if light[1] == "0" then	light[1] = "1"	else light[1] = "0" end
		if light[2] == "0" then light[2] = "1" else light[2] = "0" end
		if light[6] == "0" then light[6] = "1" else light[6] = "0" end
	end
	if i == 2 then
		if light[1] == "0" then	light[1] = "1"	else light[1] = "0" end
		if light[2] == "0" then light[2] = "1" else light[2] = "0" end
		if light[3] == "0" then light[3] = "1" else light[3] = "0" end
		if light[7] == "0" then light[7] = "1" else light[7] = "0" end
	end				
	if i == 3 then
		if light[2] == "0" then	light[2] = "1"	else light[2] = "0" end
		if light[3] == "0" then light[3] = "1" else light[3] = "0" end
		if light[4] == "0" then light[4] = "1" else light[4] = "0" end
		if light[8] == "0" then light[8] = "1" else light[8] = "0" end
	end
	if i == 4 then
		if light[3] == "0" then	light[3] = "1"	else light[3] = "0" end
		if light[4] == "0" then light[4] = "1" else light[4] = "0" end
		if light[5] == "0" then light[5] = "1" else light[5] = "0" end
		if light[9] == "0" then light[9] = "1" else light[9] = "0" end
	end
	if i == 5 then
		if light[4] == "0" then	light[4] = "1"	else light[4] = "0" end
		if light[5] == "0" then light[5] = "1" else light[5] = "0" end
		if light[10] == "0" then light[10] = "1" else light[10] = "0" end
	end	
	if i == 6 then
		if light[1] == "0" then	light[1] = "1"	else light[1] = "0" end
		if light[6] == "0" then light[6] = "1" else light[6] = "0" end
		if light[7] == "0" then light[7] = "1" else light[7] = "0" end
		if light[11] == "0" then	light[11] = "1"	else light[11] = "0" end					
	end
	if i == 7 then
		if light[2] == "0" then	light[2] = "1"	else light[2] = "0" end
		if light[6] == "0" then light[6] = "1" else light[6] = "0" end
		if light[7] == "0" then light[7] = "1" else light[7] = "0" end
		if light[8] == "0" then light[8] = "1" else light[8] = "0" end
		if light[12] == "0" then	light[12] = "1"	else light[12] = "0" end					
	end				
	if i == 8 then
		if light[3] == "0" then	light[3] = "1"	else light[3] = "0" end
		if light[7] == "0" then light[7] = "1" else light[7] = "0" end
		if light[8] == "0" then light[8] = "1" else light[8] = "0" end
		if light[9] == "0" then light[9] = "1" else light[9] = "0" end
		if light[13] == "0" then light[13] = "1" else light[13] = "0" end					
	end
	if i == 9 then
		if light[4] == "0" then	light[4] = "1"	else light[4] = "0" end
		if light[8] == "0" then light[8] = "1" else light[8] = "0" end
		if light[9] == "0" then light[9] = "1" else light[9] = "0" end
		if light[10] == "0" then light[10] = "1" else light[10] = "0" end
		if light[14] == "0" then light[14] = "1" else light[14] = "0" end					
	end
	if i == 10 then
		if light[5] == "0" then	light[5] = "1"	else light[5] = "0" end
		if light[9] == "0" then light[9] = "1" else light[9] = "0" end
		if light[10] == "0" then light[10] = "1" else light[10] = "0" end
		if light[15] == "0" then light[15] = "1" else light[15] = "0" end					
	end	
	if i == 11 then
		if light[6] == "0" then	light[6] = "1"	else light[6] = "0" end
		if light[11] == "0" then light[11] = "1" else light[11] = "0" end
		if light[12] == "0" then light[12] = "1" else light[12] = "0" end
		if light[16] == "0" then	light[16] = "1"	else light[16] = "0" end					
	end
	if i == 12 then
		if light[7] == "0" then	light[7] = "1"	else light[7] = "0" end
		if light[11] == "0" then light[11] = "1" else light[11] = "0" end
		if light[12] == "0" then light[12] = "1" else light[12] = "0" end
		if light[13] == "0" then light[13] = "1" else light[13] = "0" end
		if light[17] == "0" then	light[17] = "1"	else light[17] = "0" end					
	end				
	if i == 13 then
		if light[8] == "0" then	light[8] = "1"	else light[8] = "0" end
		if light[12] == "0" then light[12] = "1" else light[12] = "0" end
		if light[13] == "0" then light[13] = "1" else light[13] = "0" end
		if light[14] == "0" then light[14] = "1" else light[14] = "0" end
		if light[18] == "0" then light[18] = "1" else light[18] = "0" end					
	end
	if i == 14 then
		if light[9] == "0" then	light[9] = "1"	else light[9] = "0" end
		if light[13] == "0" then light[13] = "1" else light[13] = "0" end
		if light[14] == "0" then light[14] = "1" else light[14] = "0" end
		if light[15] == "0" then light[15] = "1" else light[15] = "0" end
		if light[19] == "0" then light[19] = "1" else light[19] = "0" end					
	end
	if i == 15 then
		if light[10] == "0" then	light[10] = "1"	else light[10] = "0" end
		if light[14] == "0" then light[14] = "1" else light[14] = "0" end
		if light[15] == "0" then light[15] = "1" else light[15] = "0" end
		if light[20] == "0" then light[20] = "1" else light[20] = "0" end					
	end	
	if i == 16 then
		if light[11] == "0" then	light[11] = "1"	else light[11] = "0" end
		if light[16] == "0" then light[16] = "1" else light[16] = "0" end
		if light[17] == "0" then light[17] = "1" else light[17] = "0" end
		if light[21] == "0" then	light[21] = "1"	else light[21] = "0" end					
	end
	if i == 17 then
		if light[12] == "0" then	light[12] = "1"	else light[12] = "0" end
		if light[16] == "0" then light[16] = "1" else light[16] = "0" end
		if light[17] == "0" then light[17] = "1" else light[17] = "0" end
		if light[18] == "0" then light[18] = "1" else light[18] = "0" end
		if light[22] == "0" then	light[22] = "1"	else light[22] = "0" end					
	end				
	if i == 18 then
		if light[13] == "0" then	light[13] = "1"	else light[13] = "0" end
		if light[17] == "0" then light[17] = "1" else light[17] = "0" end
		if light[18] == "0" then light[18] = "1" else light[18] = "0" end
		if light[19] == "0" then light[19] = "1" else light[19] = "0" end
		if light[23] == "0" then light[23] = "1" else light[23] = "0" end					
	end
	if i == 19 then
		if light[14] == "0" then	light[14] = "1"	else light[14] = "0" end
		if light[18] == "0" then light[18] = "1" else light[18] = "0" end
		if light[19] == "0" then light[19] = "1" else light[19] = "0" end
		if light[20] == "0" then light[20] = "1" else light[20] = "0" end
		if light[24] == "0" then light[24] = "1" else light[24] = "0" end					
	end
	if i == 20 then
		if light[15] == "0" then	light[15] = "1"	else light[15] = "0" end
		if light[19] == "0" then light[19] = "1" else light[19] = "0" end
		if light[20] == "0" then light[20] = "1" else light[20] = "0" end
		if light[25] == "0" then light[25] = "1" else light[25] = "0" end					
	end
	if i == 21 then
		if light[16] == "0" then	light[16] = "1"	else light[16] = "0" end
		if light[21] == "0" then light[21] = "1" else light[21] = "0" end
		if light[22] == "0" then light[22] = "1" else light[22] = "0" end					
	end
	if i == 22 then
		if light[17] == "0" then	light[17] = "1"	else light[17] = "0" end
		if light[21] == "0" then light[21] = "1" else light[21] = "0" end
		if light[22] == "0" then light[22] = "1" else light[22] = "0" end
		if light[23] == "0" then	light[23] = "1"	else light[23] = "0" end					
	end				
	if i == 23 then
		if light[18] == "0" then	light[18] = "1"	else light[18] = "0" end
		if light[22] == "0" then light[22] = "1" else light[22] = "0" end
		if light[23] == "0" then light[23] = "1" else light[23] = "0" end
		if light[24] == "0" then light[24] = "1" else light[24] = "0" end					
	end
	if i == 24 then
		if light[19] == "0" then	light[19] = "1"	else light[19] = "0" end
		if light[23] == "0" then light[23] = "1" else light[23] = "0" end
		if light[24] == "0" then light[24] = "1" else light[24] = "0" end
		if light[25] == "0" then light[25] = "1" else light[25] = "0" end					
	end
	if i == 25 then
		if light[20] == "0" then	light[20] = "1"	else light[20] = "0" end
		if light[24] == "0" then light[24] = "1" else light[24] = "0" end
		if light[25] == "0" then light[25] = "1" else light[25] = "0" end					
	end	
end
	
	
--Assumes 30F/second; cannot interrupt
function wait(frame)
frame = frame * 0.034
time = os.clock() + frame
	while os.clock() < time do
	end
end


--SCRIPT STORAGE-----------------------------------------------------------------------------------
--[[
---------------------------------------
---------------------------------------
---------------------------------------
---------------------------------------
---------------------------------------
---------------------------------------
---------------------------------------
--]]


---------------------------------------------------------------------------------------------------
--INITIALIZATION END-------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------
--MAIN START---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------	
buttons.interval(20, 7)
load_puzzle()

	while true do
	buttons.read()
	touch.read()
	draw.fillrect(0, 0, 960, 544, col_bg)
	draw.rect(10, 10, 940, 524, col_fg)
	draw.rect(20, 20, 920, 504, col_fg_lighter)
	draw.fillrect(549, 477, 391, 49, col_bg)
	draw.rect(610, 60, 195, 52, col_fg)
	draw.fillrect(614, 64, 187, 44, col_fg)
	draw.rect(610, 140, 195, 85, col_fg)
	local start_x = 43
	local start_y = 43
	local x = start_x
	local y = start_y
	local size = 85
	local spacing = 94
		for i = 1, 25 do
			if touch.front[1].pressed == true then
				if touch.front[1].x >= x and touch.front[1].x <= x+size and touch.front[1].y >= y and touch.front[1].y <= y+size then
				light_switch(i)
				sound.play(sfx_switch)
				moves += 1
				end
			end
		draw.rect(x, y, size, size, col_outline)
		draw.fillrect(x, y, size-1, size-1, col_light_bg)
			if light[i] == "1" then
			draw.fillrect(x+3, y+3, size-7, size-7, col_light)
			end
			if show_solution == 1 then
				if puzzle_record[current_puzzle] < 999 then
					if string.sub(solution[current_puzzle], i, i) == "X" then
					draw.rect(x, y, size, size, col_solution)
					draw.rect(x+1, y+1, size-2, size-2, col_solution)
					end
				end
			end
		x = x + spacing
			if i == 5 or i == 10 or i == 15 or i == 20 then
			x = start_x
			y = y + spacing
			end
		end
	screen.print(BAUHS93, 558, 97, "L            R", 4, col_light)
	screen.print(BAUHS93, 624, 83, "Puzzle: " .. current_puzzle, 1.8, col_light)
	screen.print(BAUHS93, 641, 160, "Moves: " .. moves, 1.5, col_light)
	screen.print(BAUHS93, 626, 195, "Record: " .. puzzle_record[current_puzzle], 1.5, col_light)
	screen.print(BAUHS93, 590, 350, "START: Reset puzzle", 1.5, col_light)
	screen.print(BAUHS93, 580, 385, "SELECT:", 1.5, col_light)
		if show_solution == 1 then
		screen.print(BAUHS93, 686, 385, "Hide solution", 1.5, col_light)
		else
		screen.print(BAUHS93, 686, 385, "Show solution", 1.5, col_light)
		end
	screen.print(BAUHS93, 542, 509, "Blackout", 5.1, col_fg_lighter)
		if puzzle_record[current_puzzle] < 999 then
		screen.print(BAUHS93, 700, 44, "COMPLETE", 1.1, col_fg)
		end
	screen:flip()
		if buttons.l then
		current_puzzle -= 1
			if current_puzzle <= 0 then
			current_puzzle = 50
			end
		moves = 0
		load_puzzle()
		end
		if buttons.r then
		current_puzzle += 1
			if current_puzzle > 50 then
			current_puzzle = 1
			end
		moves = 0
		load_puzzle()
		end
		if buttons.select then
			if show_solution == 1 then
			show_solution = 0
			else
			show_solution = 1
			end
		ini.write(dir .. "config.ini", "show_solution", show_solution)
		end
		if buttons.start then
		moves = 0
		load_puzzle()
		end	
		if blackout == true then
			if moves < puzzle_record[current_puzzle] then
			ini.write(dir .. "config.ini", "puzzle_record[" .. current_puzzle .. "]", moves)
			puzzle_record[current_puzzle] = tonumber(ini.read(dir .. "config.ini", "puzzle_record[" .. current_puzzle .. "]", 999))
			end		
		ini.write(dir .. "config.ini", "current_puzzle", current_puzzle)
		moves = 0
		load_puzzle()
		end
	blackout = true
		for i = 1, 25 do
			if light[i] == "1" then
			blackout = false
			break	
			end
		end
	end
---------------------------------------------------------------------------------------------------
--MAIN END-----------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------