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
      if DeliveryServiceAccount.create(name: 'Cuenta de challenge', delivery_service_account_id: DeliveryServiceCatalogue.find_by(var_name: 'fedex').id)
        puts 'Creacion de cuenta del challenge'
      end
    end
  end

  desc 'create attributers for provider'
  task create_attribute: :environment do
    attributers = [
      {name: 'Clave', var_name: 'key'},
      {name: 'Contraseña', var_name: 'password'},
      {name: 'Numero de cuenta', var_name: 'account_number'},
      {name: 'Metro', var_name: 'meter'},
      {name: 'Modo', var_name: 'mode'},
    ]

    attributers.each do |attri|
      if DeliveryServiceCatalogue.find_by(var_name: 'fedex').delivery_service_auth_keys.create(attri)
        puts "Atributo creaddo #{attri[:name]}"
      end
    end

  end

end