namespace :application do

  namespace :dev do
    desc 'Initialize developing models'
    task :init => :environment do
      init_dev_models
    end
  end
  
  desc 'Initialize admin user'
  task :init_admin => :environment do
    init_admin_user
  end

  desc 'Initialize shops' do
    task :init_shops
    init_shops
  end

  
  def init_admin_user
    u = User.find_or_initialize_by_login 'admin'
    u.email = 'admin@decorosas.com'
    u.password = 'admin' if u.new_record?
    u.password_confirmation = 'admin' if u.new_record?
    u.admin = true
    u.shop_id = Shop.find_by_name('Central').id rescue 0
    if u.save
      puts 'admin user initialized'
    else
      puts 'error while initializing admin user'
    end
  end

  def init_central_user
    u = User.find_or_initialize_by_login 'central'
    u.email = 'central@decorosas.com'
    u.password = 'central' if u.new_record?
    u.password_confirmation = 'central' if u.new_record?
    u.admin = false
    u.shop_id = Shop.find_by_name('Central').id
    if u.save
      puts 'admin user initialized'
    else
      puts 'error while initializing central user'
    end
  end

  def init_not_central_users
    u = User.find_or_initialize_by_login 'user'
    u.email = 'user@decorosas.com'
    u.password = 'user' if u.new_record?
    u.password_confirmation = 'user' if u.new_record?
    u.admin = false
    u.shop_id = Shop.find_by_name('Decorosas 1').id
    if u.save
      puts 'admin user initialized'
    else
      puts 'error while initializing not central user'
    end

    u = User.find_or_initialize_by_login 'user2'
    u.email = 'user2@decorosas.com'
    u.password = 'user2' if u.new_record?
    u.password_confirmation = 'user2' if u.new_record?
    u.admin = false
    u.shop_id = Shop.find_by_name('Decorosas 2').id
    if u.save
      puts 'admin user initialized'
    else
      puts 'error while initializing not central user'
    end
  end

  def init_dev_models
    init_dev_shops
    init_dev_users
    User.current_user = User.find_by_login('admin')
    init_dev_projects
    init_dev_estimates
    init_dev_measurements
    init_dev_clients
    init_dev_images
    init_dev_elements
  end

  def init_dev_users
    init_admin_user
    init_central_user
    init_not_central_users
  end

  def init_dev_projects
    puts "\nCreating projects"
    p = Project.find_or_initialize_by_id(1)
    p.code = 'Decorosas 1/Alcala_23'
    p.address = 'Alcalá 23'
    p.shop_id = 1
    p.client_id = 1
    if p.save
      puts "Project #{p.code} created"
    else
      puts "Errors while creating #{p.code} project:\n\t#{p.errors.full_messages.join("\n\t")}"
    end

  end

  def init_dev_shops
    puts "\nCreating shops"

    s = Shop.find_or_initialize_by_name('Central')
    s.central = true
    if s.save
      puts "#{s.name} shop created"
    else
      puts "Errors while creating #{s.name} shop:\n\t#{s.errors.full_messages.join("\n\t")}"
    end

    s = Shop.find_or_initialize_by_name('Decorosas 1')
    s.central = false
    if s.save
      puts "#{s.name} shop created"
    else
      puts "Errors while creating #{s.name} shop:\n\t#{s.errors.full_messages.join("\n\t")}"
    end

    s = Shop.find_or_initialize_by_name('Decorosas 2')
    s.central = false
    if s.save
      puts "#{s.name} shop created"
    else
      puts "Errors while creating #{s.name} shop:\n\t#{s.errors.full_messages.join("\n\t")}"
    end

  end

  def init_dev_estimates
    puts "\nCreating estimates"
    e = Estimate.find_or_initialize_by_id(1)
    e.price = 10000
    e.project_id = 1
    if e.save
      puts "estimate #{e.id} created"
    else
      puts "Errors while creating #{e.id} estimate:\n\t#{e.errors.full_messages.join("\n\t")}"
    end
  end

  def init_dev_measurements
    puts "\nCreating measurements"
    m = Measurement.find_or_initialize_by_project_id(1)
    m.description = 'Descripción 1'
    if m.save
      puts "Measurement for project #{m.project_id} created"
    else
      puts "Errors while creating measurement for project #{m.project_id}:\n\t#{m.errors.full_messages.join("\n\t")}"
    end
  end

  def init_dev_clients
    puts "\nCreating clients"
    c = Client.find_or_initialize_by_id(1)
    c.address ='Alcalá 232'
    c.name = 'Fulano de Tal'
    c.phone = '609123123'
    if c.save
      puts "client #{c.name} created"
    else
      puts "Errors while creating client #{c.name}:\n\t#{c.errors.full_messages.join("\n\t")}"
    end
  end

  def init_dev_images
  end

  def init_dev_elements
    puts "\nCreating elements"
    e = Element.find_or_initialize_by_id(1)
    e.cost_price = 5
    e.units = 2
    e.description = 'Elemento 1'
    e.assembly_price = 7
    e.project_id = 1
    if e.save
      puts "element #{e.id} created"
    else
      puts "Error while creating element #{e.id}:\n\t#{e.errors.full_messages.join("\n\t")}"
    end
  end

end


