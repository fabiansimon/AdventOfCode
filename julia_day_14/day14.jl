

function get_lines(path) 
    lines = []
    open(path) do file
        for line in eachline(file)
            append!(lines, [collect(line)])
        end
    end

    return lines
end

path = "./day14_input.txt"
lines = get_lines(path)

