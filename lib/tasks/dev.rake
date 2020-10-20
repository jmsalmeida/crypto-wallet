namespace :dev do
  desc "Setup development environment"
  task setup: :environment do
    if Rails.env.development?
      show_spinner('Dropping') { %x(rails db:drop) }

      show_spinner('Creating') { %x(rails db:create) } 
        
      show_spinner('Migrating') { %x(rails db:migrate) }
        
      show_spinner('Seeding') { %x(rails db:seed) }
    else
      puts 'Only runned on development envinronment'
    end
  end

  def show_spinner(message)
    spinner = TTY::Spinner.new("[:spinner] #{message} database...")
    spinner.auto_spin
    yield
    spinner.success
  end
end
