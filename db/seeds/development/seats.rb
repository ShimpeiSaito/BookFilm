1.upto(5) do |gp|
    row = rand(15..20)
    1.upto(row) do |idx|
        if idx <= 3 then
            start = 3
            last = 22
        elsif idx <= 7 then
            start = 2
            last = 23
        elsif (row - 3) < idx then
            start = 1
            last = 25 - 3
        else
            start = 1
            last = 25
        end
        Seat.create(
            seat_group: gp,
            row: idx,
            start_line: start,
            last_line: last,
            num: last - start + 1
        )
    end
end

