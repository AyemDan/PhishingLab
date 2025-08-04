# -*- mode: ruby -*-
# vi: set ft=ruby :

# Configuration variables - Set via environment or defaults
SERVER_COUNT = ENV['SERVER_COUNT'] || 1
ATTACKER_COUNT = ENV['ATTACKER_COUNT'] || 1  
CLIENT_COUNT = ENV['CLIENT_COUNT'] || 1

Vagrant.configure("2") do |config|
  # Base box - Custom lab box
  config.vm.box = "lab"
  
  # Simplified Hyper-V provider configuration
  config.vm.provider "hyperv" do |hv|
    hv.memory = 2048
  end

  # Server VMs - Core infrastructure (VPN, CA, Mail, Auth)
  (1..SERVER_COUNT.to_i).each do |i|
    config.vm.define "server-vm#{i}" do |server|
      server.vm.hostname = "server#{i}"

      # Rsync server files to VM
      server.vm.synced_folder "files/server/", "/opt/server/", type: "rsync", rsync__exclude: [".git/", ".DS_Store"], rsync__args: ["--verbose", "--archive", "--delete", "-z"]

      # Rsync ansible files to VM (only server.yml needed)
      server.vm.synced_folder "ansible/", "/tmp/ansible/", type: "rsync", rsync__exclude: [".git/", ".DS_Store"], rsync__args: ["--verbose", "--archive", "--delete", "-z"]
      
      # Move ansible files to correct location and verify
      server.vm.provision "shell", inline: <<-SHELL
        echo "Checking source files before copy:"
        ls -la /tmp/ansible/
        cat /tmp/ansible/inventory.ini
        echo "---"
        echo "Checking server files:"
        ls -la /opt/server/
        echo "---"
        mkdir -p /vagrant/ansible/playbook
        
        # Force create correct inventory file
        cat > /vagrant/ansible/inventory.ini << 'EOF'
[servers]
localhost ansible_connection=local

[attackers]
localhost ansible_connection=local

[clients]
localhost ansible_connection=local

[all:vars]
ansible_user=vagrant
ansible_host_key_checking=false
EOF
        
        cp /tmp/ansible/playbook/* /vagrant/ansible/playbook/
        echo "Server ansible files ready"
        echo "Checking ansible files after copy:"
        ls -la /vagrant/ansible/
        ls -la /vagrant/ansible/playbook/
        echo "Inventory content:"
        cat /vagrant/ansible/inventory.ini
        echo "Ansible will install and run the playbook next..."
      SHELL

      # Basic setup with Ansible Local
      server.vm.provision "ansible_local" do |ansible|
        ansible.playbook = "/vagrant/ansible/playbook/server.yml"
        ansible.inventory_path = "/vagrant/ansible/inventory.ini"
        ansible.limit = "servers"
        ansible.install_mode = "default"
        ansible.verbose = true  # Enable verbose output for debugging
        ansible.extra_vars = {
          server_id: i,
          total_servers: SERVER_COUNT,
          total_attackers: ATTACKER_COUNT,
          total_clients: CLIENT_COUNT
        }
      end
    end
  end

  # Attacker VMs - GoPhish and penetration testing tools
  (1..ATTACKER_COUNT.to_i).each do |i|
    config.vm.define "attacker-vm#{i}" do |attacker|
      attacker.vm.hostname = "attacker#{i}"

      # Rsync attacker files to VM
      attacker.vm.synced_folder "files/attacker/", "/opt/attacker/", type: "rsync", rsync__exclude: [".git/", ".DS_Store"], rsync__args: ["--verbose", "--archive", "--delete", "-z"]

      # Rsync ansible files to VM (only attacker.yml needed)
      attacker.vm.synced_folder "ansible/", "/tmp/ansible/", type: "rsync", rsync__exclude: [".git/", ".DS_Store"], rsync__args: ["--verbose", "--archive", "--delete", "-z"]
      
      # Move ansible files to correct location
      attacker.vm.provision "shell", inline: <<-SHELL
        mkdir -p /vagrant/ansible/playbook
        
        # Force create correct inventory file
        cat > /vagrant/ansible/inventory.ini << 'EOF'
[servers]
localhost ansible_connection=local

[attackers]
localhost ansible_connection=local

[clients]
localhost ansible_connection=local

[all:vars]
ansible_user=vagrant
ansible_host_key_checking=false
EOF
        
        cp /tmp/ansible/playbook/* /vagrant/ansible/playbook/
        echo "Attacker ansible files ready"
        echo "Ansible will install and run the playbook next..."
      SHELL

      # Basic setup with Ansible Local
      attacker.vm.provision "ansible_local" do |ansible|
        ansible.playbook = "/vagrant/ansible/playbook/attacker.yml"
        ansible.inventory_path = "/vagrant/ansible/inventory.ini"
        ansible.limit = "attackers"
        ansible.install_mode = "default"
        ansible.verbose = true  # Enable verbose output for debugging
        ansible.extra_vars = {
          attacker_id: i
        }
      end
    end
  end

  # Client VMs - Target users with browsers and email clients  
  (1..CLIENT_COUNT.to_i).each do |i|
    config.vm.define "client-vm#{i}" do |client|
      client.vm.hostname = "client#{i}"

      # Rsync client files to VM
      client.vm.synced_folder "files/client/", "/opt/client/", type: "rsync", rsync__exclude: [".git/", ".DS_Store"], rsync__args: ["--verbose", "--archive", "--delete", "-z"]

      # Rsync ansible files to VM
      client.vm.synced_folder "ansible/", "/tmp/ansible/", type: "rsync", rsync__exclude: [".git/", ".DS_Store"], rsync__args: ["--verbose", "--archive", "--delete", "-z"]
      
      # Move ansible files to correct location
      client.vm.provision "shell", inline: <<-SHELL
        mkdir -p /vagrant/ansible/playbook
        
        # Force create correct inventory file
        cat > /vagrant/ansible/inventory.ini << 'EOF'
[servers]
localhost ansible_connection=local

[attackers]
localhost ansible_connection=local

[clients]
localhost ansible_connection=local

[all:vars]
ansible_user=vagrant
ansible_host_key_checking=false
EOF
        
        cp /tmp/ansible/playbook/* /vagrant/ansible/playbook/
        echo "Client ansible files ready"
        echo "Ansible will install and run the playbook next..."
      SHELL

      # Basic setup with Ansible Local
      client.vm.provision "ansible_local" do |ansible|
        ansible.playbook = "/vagrant/ansible/playbook/client.yml"
        ansible.inventory_path = "/vagrant/ansible/inventory.ini"
        ansible.limit = "clients"
        ansible.install_mode = "default"
        ansible.verbose = true  # Enable verbose output for debugging
        ansible.extra_vars = {
          client_id: i
        }
      end
    end
  end
end
