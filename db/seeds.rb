table_names = %w(admins reservationdetails screens reservations seats members schedules theaters movies tickets)
table_names.each do |table_name|
    path = Rails.root.join("db/seeds", Rails.env, table_name + ".rb")
    if File.exist?(path)
        puts "Creating #{table_name}..."
        require path
    end
end