alfs = 'A'.upto('Z').to_a

1.upto(5) do |gp|
    row_n = rand(14..19)
    0.upto(row_n) do |idx|
        row = alfs[idx]

        if idx <= 3 then
            start = 3
            last = 22
        elsif idx <= 7 then
            start = 2
            last = 24
        elsif (row_n - 3) < idx then
            start = 1
            last = 25 - 3
        else
            start = 1
            last = 25
        end
        Seat.create(
            seat_group: gp,
            row: row,
            start_line: start,
            last_line: last,
            num: last - start + 1
        )
    end
end

