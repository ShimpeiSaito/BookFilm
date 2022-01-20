names = %w(admin01 admin02 admin03)
fnames = %w(齋藤新平 専修太郎 専修花子)

def random_number_generator(n)
    ''.tap { |s| n.times { s << rand(0..9).to_s } }
end

0.upto(2) do |idx|
    Admin.create(
        login_id: names[idx],
        name: fnames[idx],
        birthday: "#{rand(1980..2000)}-12-01",
        tel: random_number_generator(3) + "-" + random_number_generator(4) + "-" + random_number_generator(4),
        email: "#{names[idx]}@example.com",
        password: "admin",
        password_confirmation: "admin"
    )
end
