namespace :migrate_data do

  desc 'All Migrations'
  task all: [
    :create_user_admin,
    :create_provider,
    :create_attribute,
    :create_account
  ]

  desc 'create_user_admin'
  task create_user_admin: :environment do
    if AdminUser.create(email: 'admin_user@conserdel.mx', password: 'conserdel0123' )
      puts "Usuario creado -> admin_user@conserdel.mx, contraseña -> conserdel0123"
    end
  end
  
  desc 'create providers'
  task create_provider: :environment do
    if DeliveryServiceCatalogue.create(name: 'FeDex', var_name: 'fedex', description: 'Servicio de paqueteria')
      puts 'create provider Fedex'
      statuses = [
        { name: 'SOLICITUD EN PROCESO', var_name: 'in_process', status_equivalences:''},
        { name: 'CREACIÓN', var_name: 'created', status_equivalences: 'OC HL AP' },
        { name: 'EN TRANSITO', var_name: 'on_transit', status_equivalences: 'on_transit PU AR FD SF DP OD CC' },
        { name: 'ENTREGADO', var_name: 'delivered', status_equivalences: 'DL' },
        { name: 'EXCEPCIÓN', var_name: 'exception', status_equivalences: 'DE SE CD' },
        { name: 'ELIMINADO', var_name: 'delete', status_equivalences: '' },
        { name: 'ENVIO CANCELADO', var_name: 'cancelled', status_equivalences: 'CA' }
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