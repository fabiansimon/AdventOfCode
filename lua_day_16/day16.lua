local Queue = require("queue")

local function readFile(path)
    local file = io.open(path, "r")

    if file then
        local matrix = {}
        for line in file:lines() do
            local row = {}
            for i = 1, #line do
                table.insert(row, line:sub(i, i))
            end
            table.insert(matrix, row)
        end

        file:close()
        return matrix
    else
        print("Error happening while reading the file")
        return nil
    end
end

local function inBounds(matrix, x, y)
    return x >= 1 and x <= #matrix[1] and y >= 1 and y <= #matrix
end

local function sleep(seconds)
    os.execute("sleep " .. tonumber(seconds))
end

local function key(x, y)
    return x .. "," .. y
end

local function getLength(set)
    local count = 0
    for _, _ in pairs(set) do
        count = count + 1
    end

    return count
end


local function simulateRays(matrix)
    local directions = {
        R = { 1, 0 },
        L = { -1, 0 },
        U = { 0, -1 },
        D = { 0, 1 }
    }

    local size = #matrix[1] * #matrix
    local queue = Queue.new()
    local set = {}

    Queue.add(queue, {
        currX = 0,
        currY = 1,
        direction = "R"
    })

    local total = 0
    while true do
        if Queue.isEmpty(queue) or total > size then
            break
        end

        total = total + 1

        -- printMatrix(matrix)

        local curr = Queue.poll(queue)

        set[key(curr.currX, curr.currY)] = true

        local change = directions[curr.direction]
        local newX = curr.currX + change[1]
        local newY = curr.currY + change[2]

        local vertical = curr.direction == 'U' or curr.direction == 'D'
        local horizontal = curr.direction == 'L' or curr.direction == 'R'

        if not inBounds(matrix, newX, newY) then
            goto continue
        end

        local d = matrix[newY][newX]

        if d == '.' then
            matrix[newY][newX] = 'v'
        end

        if d == '|' then
            if vertical then
                Queue.add(queue, {
                    currX = newX,
                    currY = newY,
                    direction = curr.direction
                })
            else
                Queue.add(queue, {
                    currX = newX,
                    currY = newY,
                    direction = "U"
                })

                Queue.add(queue, {
                    currX = newX,
                    currY = newY,
                    direction = "D"
                })
            end
        end
        
        if d == '-' then
            
            if horizontal then
                Queue.add(queue, {
                    currX = newX,
                    currY = newY,
                    direction = curr.direction
                })
            else
                Queue.add(queue, {
                    currX = newX,
                    currY = newY,
                    direction = "L"
                })
    
                Queue.add(queue, {
                    currX = newX,
                    currY = newY,
                    direction = "R"
                })
            end
        end

        if d == '.' or d == 'v' then
            Queue.add(queue, {
                currX = newX,
                currY = newY,
                direction = curr.direction
            })
        end

        if d == '/' then
            local move
            if curr.direction == 'R' then
                move = "U"
            end
            if curr.direction == 'L' then
                move = "D"
            end
            if curr.direction == 'D' then
                move = "L"
            end
            if curr.direction == 'U' then
                move = "R"
            end

            Queue.add(queue, {
                currX = newX,
                currY = newY,
                direction = move
            })
        end

        if d == '\\' then
            local move
            if curr.direction == 'R' then
                move = "D"
            end
            if curr.direction == 'L' then
                move = "U"
            end
            if curr.direction == 'D' then
                move = "R"
            end
            if curr.direction == 'U' then
                move = "L"
            end

            Queue.add(queue, {
                currX = newX,
                currY = newY,
                direction = move
            })
        end

        ::continue::
    end

    printMatrix(matrix)
    return getLength(set)-1
end



function printMatrix(matrix)
    if matrix then
        for _, row in ipairs(matrix) do
            print(table.concat(row))
        end
    end
    print("")
end

local filePath = "./day16_input.txt"
local matrix = readFile(filePath)

local res = simulateRays(matrix)

print(res)