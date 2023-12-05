require 'set'
file_path = "./dayFour_input.txt"

File.open(file_path, 'r') do |file|
    points = 0

    file.each_line do |line|
        sides = line.split(":")[1].split("|")
        curr_points = 0
        
        winning = Set.new
        sides[0].split.each do |number|
            winning.add(number)
        end

        sides[1].split.each do |number|
            if winning.include?(number)
                curr_points = (curr_points == 0) ? 1 : curr_points * 2
            end
        end

        points += curr_points
    end 

    puts points
end
