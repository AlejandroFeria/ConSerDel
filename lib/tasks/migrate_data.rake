namespace :migrate_data do
  
  desc 'create providers'
  task create_provider: :environment do
    if DeliveryServiceCatalogue.create(name: 'FeDex', var_name: 'fedex', description: 'Servicio de paqueteria')
      puts 'create provider Fedex'
      statuses = [
        { name: 'CREACIÓN', var_name: 'CREATED', status_equivalences: 'CREATED' },
        { name: 'EN TRANSITO', var_name: 'ON_TRANSIT', status_equivalences: 'ON_TRANSIT' },
        { name: 'ENTREGADO', var_name: 'DELIVERED', status_equivalences: 'DELIVERED' },
        { name: 'EXCEPCIÓN', var_name: 'EXCEPTION', status_equivalences: 'EXCEPTION' }
      ]

      statuses.each do |status|
        puts "Creacion de status #{status[:name]}" if ServiceStatusCatalogue.create(status)
      end 
      if DeliveryServiceAccount.create(name: 'Cuenta de challenge')
        puts 'Creacion de cuenta del challenge'
      end
    end
  end

  desc 'create attributers for provider'
  task create_attribute: :environment do

  end

end