

function get_lines(path)
    lines = []
    open(path) do file
        for line in eachline(file)
            for (index, c) in enumerate(collect(line))
                while length(lines) < index
                    push!(lines, [])
                end
                push!(lines[index], c)
            end
        end
    end
    return lines
end

function get_total_weight(lines)
    border = length(lines[1])
    index = border
    total = 0
    for line in lines
        index = border
        for (i, c) in enumerate(line)
            if (c == 'O')
                total += index
                index -= 1
            end

            if (c == '#') 
                index = border-i
            end
        end
    end

    return total
end

function format_matrix(lines)
    border = length(lines[1])

    for (row, line) in enumerate(lines)
        index = border

        for (i, c) in enumerate(line)
            if c == 'O'
                if i != border - index + 1
                    # Swap 'O' and '.'
                    line[border - index + 1], line[i] = 'O', '.'
                end

                index -= 1
            end

            if c == '#'
                index = border - i
            end
        end
    end
end

function turn_matrix(lines)
    turned = []
    for line in lines
        for (index, c) in enumerate(collect(line))
            while length(turned) < index
                push!(turned, [])
            end
            push!(turned[index], c)
        end
    end
    return turned
end

function print_matrix(lines)
    for (i, line) in enumerate(lines)
        for (j, _) in enumerate(line)
            print(lines[j][i])
        end
        println()
    end
    println()
end


path = "./day14_input.txt"
lines = get_lines(path)
# total_weight = get_total_weight(lines)
println(lines)
println()

format_matrix(lines)
turned = turn_matrix(lines)

# println(lines)
println(turned)
println()
format_matrix(turned)
println(turned)
println()
