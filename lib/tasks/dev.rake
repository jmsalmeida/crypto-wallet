namespace :dev do
  desc "Setup development environment"
  task setup: :environment do
    if Rails.env.development?
      show_spinner('Dropping') { %x(rails db:drop) }

      show_spinner('Creating') { %x(rails db:create) } 
        
      show_spinner('Migrating') { %x(rails db:migrate) }

      %x(rails dev:add_coins)

      %x(rails dev:add_mining_types)
    else
      puts 'Only runned on development envinronment'
    end
  end

  desc "Create coins"
  task add_coins: :environment do
    show_spinner('Seeding coins to') do
      coins = [
        {
          description: 'Bitcoin',
          acronym: 'BTC',
          url_image: 'https://img2.gratispng.com/20180604/zya/kisspng-bitcoin-com-cryptocurrency-logo-zazzle-kibuba-btc-5b15aa1f157d09.468430171528146463088.jpg'
        },

        {
          description: 'Etherium',
          acronym: 'ETH',
          url_image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/ETHEREUM-YOUTUBE-PROFILE-PIC.png/768px-ETHEREUM-YOUTUBE-PROFILE-PIC.png'
        },

        {
          description: 'Dash',
          acronym: 'DASH',
          url_image: 'https://cryptomined.com/images/flags/dash_circle_Flag_1.png'
        }
      ]

      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "Create coins"
  task add_mining_types: :environment do
    show_spinner('Seeding mining to') do
      mining_types = [
        {
          description: 'Proof of Work',
          acronym: 'PoW',
        },

        {
          description: 'Proof of Stake',
          acronym: 'PoS',
        },

        {
          description: 'Proof of Capacity',
          acronym: 'PoC',
        },
      ]

      mining_types.each do |type|
        MiningType.find_or_create_by!(type)
      end
    end
  end

  def show_spinner(message)
    spinner = TTY::Spinner.new("[:spinner] #{message} database...")
    spinner.auto_spin
    yield
    spinner.success
  end
end
