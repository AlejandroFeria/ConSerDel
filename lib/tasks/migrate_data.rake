namespace :migrate do
  desc "create accounts"
  task create_accouns: :enviroment do
    if DeliveryServiceAccount.create(name: "Demo FeDex")
        DeliveryServiceAuthKey
    end
  end
end