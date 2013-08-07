namespace :db do
  desc "Fill test database with MeetupTimes, Categories, and Locations"
  task populate_test: :environment do
    days = %w{Sunday Monday Tuesday Wednesday Thursday Friday Saturday}
    periods = ["Anytime", "Any Morning Time", "Any Afternoon Time",
      "Any Evening Time", "Unavailable", "Before 9am", "Lunchtime", "After 5pm"]
    locations = ["Inner SE", "Inner NE", "Downtown", "Old Town & The Pearl",
      "Inner NW", "Inner SW"]
    categories = ["Basic Web", "HTML/CSS", "Github/Heroku/Command Line",
      "Beginning JavaScript", "Beginning Ruby", "Sinatra", "APIs"]

    DatabaseCleaner.clean_with(:truncation, only: ['meetup_times', 'categories',
                              'locations'])

    #create meetup_times
    days.each do |day|
      periods.each do |period|
        MeetupTime.create(day: day, period: period)
      end
    end

    locations.each { |location| Location.create(name: location) }
    categories.each { |category| Category.create(name: category) }
  end
end