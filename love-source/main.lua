-- This is free and unencumbered software released into the public domain.
--
-- Anyone is free to copy, modify, publish, use, compile, sell, or
-- distribute this software, either in source code form or as a compiled
-- binary, for any purpose, commercial or non-commercial, and by any
-- means.
--
-- In jurisdictions that recognize copyright laws, the author or authors
-- of this software dedicate any and all copyright interest in the
-- software to the public domain. We make this dedication for the benefit
-- of the public at large and to the detriment of our heirs and
-- successors. We intend this dedication to be an overt act of
-- relinquishment in perpetuity of all present and future rights to this
-- software under copyright law.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
-- OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
-- ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-- OTHER DEALINGS IN THE SOFTWARE.
--
-- For more information, please refer to <http://unlicense.org/>

local utf8 = require("utf8")

--local moon = require("moonlight")
local font
local interface, textbox, layout, output = {}, {}, {}, {}

-- constants
local UP = -1
local DOWN = 1
local LEFT = -1
local RIGHT = 1

-- Table of Layout Ratios
local layout_ = {
	{
		height = 0.186666666666666703,
		name = "map",
		width = 0.160000000000000031,
		x = 0.819999999999999951,
		y = 0.239999999999999991,
	},
	{
		height = 0.186666666666666731,
		name = "amulet",
		width = 0.160000000000000031,
		x = 0.819999999999999951,
		y = 0.026666666666666668,
	},
	{
		height = 0.07999999999999996,
		name = "input",
		width = 0.780000000000000027,
		x = 0.020000000000000018,
		y = 0.906666666666666732,
	},
	{
		height = 0.533333333333333437,
		name = "inventory",
		width = 0.160000000000000031,
		x = 0.819999999999999951,
		y = 0.45333333333333331,
	},
	{
		height = 0.853333333333333499,
		name = "output",
		width = 0.780000000000000027,
		x = 0.020000000000000018,
		y = 0.026666666666666616,
	},
}

--  _____ _____ _____ _____ _____ _____ _____ _____ _____ _____
-- |_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|

function love.load ()

    -- load font resource
    local size = 18
    local hinting = "mono"
    font = love.graphics.newFont("FreeMono.ttf", size, hinting)
    love.graphics.setFont(font)

    layout:load()
    interface:load()
    textbox:load()
    output:load()

end

function love.draw ()
    interface:draw()
    love.graphics.setColor(1,1,1)
    --love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
end

function love.update (dt)

    local fpslimit = 1/7
    if dt < fpslimit then
        love.timer.sleep(fpslimit - dt)
    end

    textbox:update(dt)
    output:update(dt)
end

function love.keypressed (key, scancode, isrepeat)
    textbox:keypressed(key, scancode, isrepeat)
    output:keypressed(key, scancode, isrepeat)
    if key == "f10" then
        love.event.quit()
    end
end

function love.mousemoved (x, y, dx, dy, istouch)

end

function love.mousepressed (x, y, button, istouch, presses)

end

function love.mousereleased (x, y, button, istouch, presses)

end

function love.textinput (text)
    textbox:textinput(text)
end

--  _____ _____ _____ _____ _____ _____ _____ _____ _____ _____
-- |_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|
-- Interface

function interface.load (self)
    -- load positions of the various layout areas
    self.input = layout:calculate("input")
    self.output = layout:calculate("output")
    self.input_bg = {0, 0, .6}
    self.output_bg = {0, 0, .6}
end

function interface.draw (self)

    -- draw input area
    love.graphics.push()
    love.graphics.translate(self.input.x, self.input.y)
    love.graphics.setColor(self.input_bg)
    love.graphics.rectangle("fill", 0, 0, self.input.width, self.input.height)
    -- offset the input down
    love.graphics.translate(0, 10)
    -- print input chevron
    love.graphics.setColor(1, 1, 0)
    love.graphics.print(">")
    love.graphics.translate(20, 0)
    textbox:draw(1, 1, 0) -- r,g,b
    love.graphics.pop()

    -- draw output area
    love.graphics.push()
    love.graphics.translate(self.output.x, self.output.y)
    love.graphics.setColor(self.output_bg)
    love.graphics.rectangle("fill", 0, 0, self.output.width, self.output.height)
    -- render output text
    love.graphics.setColor(1, 1, 0)
    output:draw()
    love.graphics.pop()

end

function interface.update (self, dt)

end

function interface.keypressed (self, key)

end

function interface.process_input (self, text)
    if string.match(text, "^quit") or string.match(text, "^bye") then
        love.event.quit()
        return
    end
    output:append_text("> "..text)
end

--  _____ _____ _____ _____ _____ _____ _____ _____ _____ _____
-- |_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|

function layout.load (self)
    self.data = {
        {
            height = 0.186666666666666703,
            name = "map",
            width = 0.160000000000000031,
            x = 0.819999999999999951,
            y = 0.239999999999999991,
        },
        {
            height = 0.186666666666666731,
            name = "amulet",
            width = 0.160000000000000031,
            x = 0.819999999999999951,
            y = 0.026666666666666668,
        },
        {
            height = 0.07999999999999996,
            name = "input",
            width = 0.780000000000000027,
            x = 0.020000000000000018,
            y = 0.906666666666666732,
        },
        {
            height = 0.533333333333333437,
            name = "inventory",
            width = 0.160000000000000031,
            x = 0.819999999999999951,
            y = 0.45333333333333331,
        },
        {
            height = 0.853333333333333499,
            name = "output",
            width = 0.780000000000000027,
            x = 0.020000000000000018,
            y = 0.026666666666666616,
        },
    }
end

function layout.calculate (self, name)
    local scr_width, scr_height = love.graphics.getDimensions()
    for _, panel in ipairs(self.data) do
        if panel.name == name then
            -- TODO named properties
            local dimensions = {
                ["x"]=panel.x * scr_width,
                ["y"]=panel.y * scr_height,
                ["width"]=panel.width * scr_width,
                ["height"]=panel.height * scr_height}
            return dimensions
        end
    end
    assert(false, ("no layout named %q" % name))
end

--  _____ _____ _____ _____ _____ _____ _____ _____ _____ _____
-- |_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|

function textbox.load (self)
    -- controls cursor position and limit
    self.max_column = 80
    self.cursor_column = 1
    self.cursor_row = 1
    self.cursor_x = 0
    self.cursor_y = 0
    -- controls cursor blinking
    self.blink_delay = 0.75
    self.blink_dt = 0
    self.blink_on = true
    -- the buffer contains the user input
    self.buffer = " "
    -- track historical inputs
    self.history = { "look", "open mailbox", "take leaflet" }
    self.history_index = nil
    -- provides auto complete
    self.auto_words = { "open", "close", "go", "take", "read", "mailbox", "leaflet" }
    self.auto_match = nil
    -- measure the width of a character
    self.box_width = font:getWidth("=")
    self.box_height = font:getHeight("=")
    -- calculate cursor position now
    self:move(0, 0)
end

function textbox.delete_character (self, advance_cursor)
    -- measure the line
    local buffer_line = self.buffer
    local line_length = utf8.len(buffer_line)
    -- backspace if not on the first column
    local can_backspace = self.cursor_column > 1
    -- delete if not on the last column
    local can_delete = self.cursor_column < line_length
    -- test for operation
    if not can_backspace and not can_delete then
        return
    end
    -- get the cursor offset
    local cursor_offset = utf8.offset(buffer_line, self.cursor_column)
    if cursor_offset then
        -- cut the character at the cursor
        if advance_cursor then
            if can_backspace then
                buffer_line = string.sub(buffer_line, 1, cursor_offset-2) .. string.sub(buffer_line, cursor_offset, -1)
                self.cursor_column = self.cursor_column - 1
            end
        else
            if can_delete then
                buffer_line = string.sub(buffer_line, 1, cursor_offset-1) .. string.sub(buffer_line, cursor_offset+1, -1)
            end
        end
        -- update the buffer
        self.buffer = buffer_line
        -- calculate cursor position
        self:move(0, 0)
    end
end

function textbox.draw (self, r, g, b)
    -- print auto suggestion
    if self.auto_match then
        love.graphics.setColor(r, g, b, .3)
        love.graphics.print(self.auto_match, self.auto_word_position)
    end
    -- print the buffer
    love.graphics.setColor(r, g, b, 1)
    love.graphics.print(self.buffer)
    -- render the cursor
    if self.blink_on then
        love.graphics.setColor(r, g, b, .5)
        love.graphics.rectangle("fill", self.cursor_x, self.cursor_y, self.box_width, self.box_height)
    else
        love.graphics.setColor(r, g, b, .2)
        love.graphics.rectangle("fill", self.cursor_x, self.cursor_y, self.box_width, self.box_height)
    end
end

--- Returns the number of characters to reach a " " to the right of the cursor.
function textbox.jumps_to_next_space (self)
    local line = self.buffer
    local line_length = line:len()
    local start = self.cursor_column
    local match = 0
    local is_spaced = 0
    if line then
        for n = start, line_length do
            match = n
            local letter = line:sub(n, n)
            if letter == " " then
                is_spaced = 1
                break
            end
        end
    end
    return match - self.cursor_column + is_spaced
end

function textbox.jumps_to_prev_space (self)
    local line = self.buffer
    local start = self.cursor_column-2
    local match = 0
    local is_spaced = 0
    if line then
        for n = start, 1, -1 do
            match = n
            local letter = line:sub(n, n)
            if letter == " " then
                is_spaced = 1
                break
            end
        end
    end
    return match - self.cursor_column + is_spaced
end

function textbox.keypressed (self, key, scancode, isrepeat)

    local control_down = love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")
    --local shift_down = love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift")
    local alt_down = love.keyboard.isDown("lalt") or love.keyboard.isDown("ralt")

    -- control function keys
    if control_down then
        if key == "left" then
            -- word jump
            self:move(self:jumps_to_prev_space(), 0)
        elseif key == "right" then
            -- word jump
            self:move(self:jumps_to_next_space(), 0)
        end
    end

    -- no control or alt function keys
    if not control_down and not alt_down then
        if key == "left" then
            -- cursor navigation
            self:move(LEFT, 0)
        elseif key == "right" then
            -- cursor navigation
            self:move(RIGHT, 0)
        elseif key == "up" then
            -- scroll to older history
            self:scan_history(UP)
        elseif key == "down" then
            -- scroll to recent history
            self:scan_history(DOWN)
        elseif key == "home" then
            -- jump to start of line
            self:move(-self.max_column, 0)
        elseif key == "end" then
            -- jump to end of line
            self:move(self.max_column, 0)
        elseif key == "backspace" then
            -- erase character before cursor
            self:delete_character(true)
            self:match_auto_com()
        elseif key == "delete" then
            -- erase character after cursor
            self:delete_character(false)
            self:match_auto_com()
        elseif key == "escape" then
            -- clear input
            self.buffer = " "
            self:reset_history_position()
            self:match_auto_com()
        elseif key == "return" then
            self:record_history(self.buffer)
            interface:process_input(self.buffer)
            self.buffer = " "
            self:move(0, 0)
            self:match_auto_com()
        end
    end

end

function textbox.match_auto_com (self)
    -- negate previous match
    self.auto_match = nil
    -- load the input buffer minus the ending space
    local buffer = string.sub(self.buffer, 1, -2)
    -- extract the last word by reversing the buffer ...
    buffer =  string.reverse(buffer)
    -- and matching on space or EOL ...
    local p1, p2 = string.find(buffer, "%w+")
    if p1 and p2 then
        -- and cutting that part out ...
        buffer = string.sub(buffer, p1, p2)
        -- and restoring the order
        buffer = string.reverse(buffer)
        -- store word size and position for future use
        self.auto_word_size = utf8.len(buffer)
        self.auto_word_position = (utf8.len(self.buffer)-self.auto_word_size-1)*self.box_width
        -- scan for matches
        for _, query in ipairs(self.auto_words) do
            -- include match anchor
            local match = string.match(query, "^"..buffer)
            --print("match ^"..buffer.." in "..query.." "..(match and "*" or ""))
            if match and (buffer ~= query) then
                self.auto_match = query
                break
            else
                -- an exact match means word completed
                self.auto_match = nil
            end
        end
    end
end

function textbox.move (self, column_delta)

    local cc = self.cursor_column
    local cr = self.cursor_row
    local line = self.buffer
    local line_length = line:len()

    -- stop moving at line's end
    local max_column = math.min(self.max_column, line_length)

    self.cursor_column = math.min(max_column, math.max(1, cc + column_delta))

    -- subtract to zero-based coordinates
    self.cursor_x = (self.cursor_column-1) * self.box_width

end

function textbox.record_history (self, text)
    local history_size = 20
    -- skip if duplicating the last entry
    if #self.history > 0 and self.history[#self.history] == text then
        return
    end
    table.insert(self.history, text)
    -- cull
    while #self.history > history_size do
        table.remove(self.history, 1)
    end
    self:reset_history_position()
end

function textbox.reset_history_position (self)
    self.history_index = nil
    self:move(0, 0)
end

function textbox.scan_history (self, direction)
    -- skip empty history
    if #self.history < 1 then
        return
    end
    -- set initial position to the latest entry
    if not self.history_index then
        -- start scan operation on up scroll only
        if direction == UP then
            self.history_index = #self.history
        end
    else
        local new_idx = self.history_index + direction
        -- scrolling down past the boundary clears the input
        if new_idx > #self.history then
            self.history_index = nil
        else
            new_idx = math.min(#self.history, new_idx)
            new_idx = math.max(1, new_idx)
            self.history_index = new_idx
        end
    end
    -- load the history into the buffer
    if self.history_index then
        self.buffer = self.history[self.history_index]
        -- ensure post-space exist
        if not string.match(self.buffer, "%s$") then
            self.buffer = self.buffer .. " "
        end
    else
        -- clear the buffer
        self.buffer = " "
    end
    -- position cursor EOL
    self:move(self.max_column, 0)
    -- perform auto complete match
    self:match_auto_com()
end

function textbox.textinput (self, text)

    -- space applies auto complete
    local perform_autocomplete = text == " " and self.auto_match
    -- accept space or alpha-numeric
    local valid_input = text == " " or string.match(text, "%w+")

    if perform_autocomplete then
        -- cut the partial
        local buff = string.sub(self.buffer, 1, -self.auto_word_size-2)
        -- add auto complete
        buff = buff..self.auto_match.."  "
        self.buffer = buff
        --self.auto_match = nil
        self:move(self.max_column, 0)
    elseif valid_input then
        -- manipulate the input buffer
        local buffer_line = self.buffer
        local cursor_offset = utf8.offset(buffer_line, self.cursor_column)
        if cursor_offset then
            -- insert input line into buffer line
            buffer_line = string.sub(buffer_line, 1, cursor_offset-1) .. text .. string.sub(buffer_line, cursor_offset, -1)
            -- update the buffer
            self.buffer = buffer_line
            -- advance the cursor to the length of the input
            self.cursor_column = self.cursor_column + utf8.len(text)
        end
    end
    -- calculate cursor position
    self:move(0, 0)
    self:match_auto_com()
    -- hide auto match when line ends with space
    if string.match(self.buffer, "%s%s$") then
        self.auto_match = nil
    end

end

function textbox.update (self, dt)
    -- flip cursor blink state
    self.blink_dt = self.blink_dt + dt
    if self.blink_dt > self.blink_delay then
        self.blink_on = not self.blink_on
        self.blink_dt = 0
    end
end


--  _____ _____ _____ _____ _____ _____ _____ _____ _____ _____
-- |_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|

function output.append_text (self, text)
    -- wrap words before this many columns
    local max_seg_len = 50
    -- insert newlines to wrap text inside the screen
    local last_known_space = 0
    local segment_len = 0
    for pos = 1, utf8.len(text) do
        local pos_offset = utf8.offset(text, pos)
        local the_char = string.sub(text, pos_offset, pos_offset)
        segment_len = segment_len + 1
        if the_char == " " then
            last_known_space = pos
        end
        if last_known_space > 0 and segment_len > max_seg_len then
            -- reset segment count
            segment_len = 0
            -- insert newline
            text = string.sub(text, 1, last_known_space-1) .. "\n" .. string.sub(text, last_known_space, -1)
            pos = last_known_space
            print("segmenting text at "..pos.." to "..text)
        end
    end
    -- add output text and trim the buffer to size
    table.insert(self.buffer, text)
    while #self.buffer > self.size do
        table.remove(self.buffer, 1)
    end
    -- invalidate the drawable
    self.text_object = nil
end

function output.append_image (self, todo)
    assert(false, "for future me to implement")
end

function output.draw (self)

    -- start printing DISPLAY_NUMBER from the end
    local start = #self.buffer - self.DISPLAY_NUMBER - self.scroll_offset
    local end_pos = start + self.DISPLAY_NUMBER

    -- clamp
    start = math.max(1, start)
    start = math.min(start, #self.buffer)

    for pos = start, end_pos do
        local entry = self.buffer[pos]
        if entry then
            love.graphics.print(entry, 0, (pos-start)*self.font_height)
        end
    end

end

function output.keypressed (self, key, scancode, isrepeat)

    local control_down = love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")
    local alt_down = love.keyboard.isDown("lalt") or love.keyboard.isDown("ralt")

    -- alt function keys
    if true or control_down then
        if key == "pageup" then
            -- scroll to older history
            self:scroll_history(DOWN)
        elseif key == "pagedown" then
            -- scroll to recent history
            self:scroll_history(UP)
        end
    end

end

function output.load (self)
    -- maximum entries saved at any given time
    self.size = 120
    -- number of lines drawn per page
    self.DISPLAY_NUMBER = 24
    -- measure font line height
    self.font_height = font:getHeight("=")
    -- output scroll-back offset
    self.scroll_offset = 0
    -- content buffer
    self.buffer = {
        "1> look",
        "Proin eget leo interdum, facilisis ante at, fermentum nisl.",
        "",
        "2> open mailbox",
        "Donec elementum justo id neque ultricies euismod.",
        "",
        "3> take leaflet",
        "In lobortis metus eu sem tempor iaculis.",
        "",
        "4> read it",
        "Praesent vel est nec dolor convallis porta sed ultrices magna.",
        "",
        "5> look",
        "Proin eget leo interdum, facilisis ante at, fermentum nisl.",
        "",
        "6> open mailbox",
        "Donec elementum justo id neque ultricies euismod.",
        "",
        "7> take leaflet",
        "In lobortis metus eu sem tempor iaculis.",
        "",
        "8> read it",
        "Praesent vel est nec dolor convallis porta sed ultrices magna.",
        "",
        "9> look",
        "Proin eget leo interdum, facilisis ante at, fermentum nisl.",
        "",
        "12> open mailbox",
        "Donec elementum justo id neque ultricies euismod.",
        "",
        "13> take leaflet",
        "In lobortis metus eu sem tempor iaculis.",
        "",
        "14> read it",
        "Praesent vel est nec dolor convallis porta sed ultrices magna.",
        "",
        "15> look",
        "Proin eget leo interdum, facilisis ante at, fermentum nisl.",
        "",
        "16> open mailbox",
        "Donec elementum justo id neque ultricies euismod.",
        "",
        "17> take leaflet",
        "In lobortis metus eu sem tempor iaculis.",
        "",
        "18> read it",
        "Praesent vel est nec dolor convallis porta sed ultrices magna.",
        "",
    }
end

function output.scroll_history (self, direction)
    local lines_to_scroll = 8
    local n = self.scroll_offset + (direction*lines_to_scroll)
    -- clamp to buffer boundaries
    n = math.max(0, n)
    n = math.min(#self.buffer-self.DISPLAY_NUMBER-1, n)
    self.scroll_offset = n
    --print("output offset "..self.scroll_offset.." buff size "..#self.buffer)
end

function output.update (self, dt)

end

