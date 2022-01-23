times = %w(6 12 18 8 14 20 10 16)

1.upto(3) do |thea_idx|
    theater = Theater.find(thea_idx)
    movies = Movie.all.sample(rand(5..10))
    scn = [1,8,2,7,3,6,4,5]
    for movie in movies do
        0.upto(6) do |day|
            date = Date.new(Time.zone.now.year, Time.zone.now.month,(Time.zone.now.day) + day)
            0.upto(2) do |t|
                time = Time.new(date.year, date.month, date.day, times[t + day], 0, 0, '+09:00')
                etime = time + (movie.screening_time * 60)
                Schedule.create(
                    thea: theater,
                    mov: movie,
                    screen_no: rand(1..8),
                    screening_date: date,
                    starttime: time,
                    endtime: etime
                )
            end
        end
    end
end
