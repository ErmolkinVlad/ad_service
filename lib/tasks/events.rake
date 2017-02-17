namespace :events do
  desc "Rake task to get events data"
  task :set_archive do
    @advert = Advert.all
    puts "#{Time.now} - Success!"
  end
end