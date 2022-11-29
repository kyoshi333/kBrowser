-- [[ kBrowser ]]--

local config = {
    v = 0.1,
    running = true,
    sNode = "https://krist.dev",
}

local sandboxConfig = {
    filesystem = false
}

if not term.isColour() then
    error(shell.getRunningProgram()..": No colour support", 0)
end

local x, y = term.getSize()

local draw = {
    clear = function()
        term.setBackgroundColour(colours.grey)
        term.clear()
        term.setCursorPos(1, 1)
    end,

    quit = function()
        term.setBackgroundColour(colours.black)
        term.setTextColour(colours.white)
        term.clear()
        term.setCursorPos(1, 1)

        local message = {
            "See you again soon!",
            "Have a good one, cobba!"
        }

        print(message[math.random(1, #message)])
    end,

    welcome = function()
        term.setBackgroundColour(colours.grey)
        term.setCursorPos(1, 1)
        term.clear()

        term.setBackgroundColour(colours.lightGrey)
        for i = 1, 3 do
            term.setCursorPos(1, i)
            term.clearLine()
        end

        term.setTextColour(colours.grey)
        term.setCursorPos(2, 2)
        print("kBrowser "..config.v)

        term.setTextColour(colours.lightGrey)
        term.setBackgroundColour(colours.grey)
        term.setCursorPos(2, 5)
        print("Before you visit a website, please evaluate the")
        term.setCursorPos(2, 6)
        print("permission settings below.")
        
        term.setCursorPos(2, 8)
        print("[1] Read/Write: "..tostring(sandboxConfig.filesystem))

        term.setCursorPos(2, y - 2)
        print("[S] Search")
        term.setCursorPos(2, y - 1)
        print("[Q] Quit")
    end,
    navigation = function()
        term.setBackgroundColour(colours.lightGrey)
        
        for i = 1, 3 do
            term.setCursorPos(1, i)
            term.clearLine()
        end

        term.setCursorPos(2, 2)
        term.setTextColour(colours.grey)
        term.write("[Q]uit [S]earch")
    end
}

local search = function()
    draw.clear()
    draw.navigation()

    while config.running == true do
        local _, k = os.pullEvent("key")
        if k == keys.s then
            term.write(" -> ")
            local input = read()

            -- check if domain exists
            -- check if domain has valid A record
            -- GET website body
            -- Filesystem sandbox
            -- Render website body

        elseif k == keys.q then
            config.running = false
            draw.quit()
        end
    end
end

while config.running == true do
    draw.welcome()
    
    local _, k = os.pullEvent("key")
    if k == keys.one then
        if sandboxConfig.filesystem == false then
            sandboxConfig.filesystem = true
        elseif sandboxConfig.filesystem == true then
            sandboxConfig.filesystem = false
        end
    elseif k == keys.s then
        search()
    elseif k == keys.q then
        config.running = false
        draw.quit()
    end
end