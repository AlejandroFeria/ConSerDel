namespace :migrate do
  
  desc "create providers"
  task create_provider: :enviroment do
    if DeliveryServiceCatalogue.create(name: "FeDex", var_name: "fedex")
      puts "create provider Fedex"
    end
  end

  desc "create attributers for provider"
  task create_attribute: :enviroment do
    option = {
      []
    }

  end

  desc "create accounts"
  task create_accouns: :enviroment do
    if DeliveryServiceAccount.create(name: "Demo FeDex")
      
    end
  end
end