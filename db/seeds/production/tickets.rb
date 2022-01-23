types = %w(大人 中高生 小学生 幼児（3歳未満）)
amount = [1800, 1500, 1000, 600]

0.upto(3) do |idx|
    Ticket.create(
        t_type: types[idx],
        total: amount[idx]
    )
end