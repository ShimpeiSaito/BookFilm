times = %w(9 12 15 18)

1.upto(3) do |thea_idx|
    theater = Theater.find(thea_idx)
    movies = Movie.all.sample(rand(13..20))
    scn = [1,2,3,4,5,6,7,8,8,7,6,5,4,3,2,1]
    for movie in movies do
        0.upto(6) do |day|
            date = Date.new(Time.zone.now.year, Time.zone.now.month,(Time.zone.now.day) + day)
            0.upto(3) do |t|
                time = Time.new(date.year, date.month, date.day, times[t], 0, 0, '+09:00')
                etime = time + (movie.screening_time * 60)
                Schedule.create(
                    thea: theater,
                    mov: movie,
                    screen_no: scn[t + day],
                    screening_date: date,
                    starttime: time,
                    endtime: etime
                )
            end
        end
    end
end
