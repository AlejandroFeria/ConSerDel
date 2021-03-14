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

  desc 'create account for demo'
  task create_account: :environment do
    fedex = DeliveryServiceCatalogue.find_by(var_name: 'fedex')
    if account = DeliveryServiceAccount.create(name: 'Cuenta de challenge', delivery_service_catalogue_id: fedex.id)
      puts 'Creacion de cuenta del challenge'
      values = [
        {var_key: 'key', value: 'VZ0tu2xxC4LKxZY6'},
        {var_key: 'password', value: 'AKOh8wjdYsJtNI6CFKaxPFLka'},
        {var_key: 'account_number', value: '802388543'},
        {var_key: 'meter', value:'100495015'},
        {var_key: 'mode', value: 'test'},
      ]
      values.each do |auth_key|
        config_value = fedex.delivery_service_auth_keys.find_by(var_name: auth_key[:var_key]).delivery_config_values.new(delivery_service_account_id: account.id, value:auth_key[:value])
        if config_value.save
          puts "authenticate key creada #{auth_key[:var_key]}"
        end
      end

    end
  end

end