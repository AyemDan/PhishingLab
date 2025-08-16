# Attacker VM: GoPhish Setup Guide

This folder contains everything needed to run GoPhish (a phishing simulation tool) and its templates inside the attacker VM. All files here are automatically copied to the VM when you start the lab—no manual copying is needed.

## What Happens Automatically?
- All files in this folder (including `docker-compose.yml` and the `templates/` directory) are synced to the attacker VM.
- GoPhish is set up using Docker, so you do not need to install anything manually.

## How to Start GoPhish (Step-by-Step)

1. **Start the Lab**
   - In the main project folder, run:
     ```sh
     vagrant up
     ```
   - This will create and configure all VMs, including the attacker VM.

2. **Access the Attacker VM**
   - Enter the attacker VM by running:
     ```sh
     vagrant ssh attacker-vm1
     ```
   - (If you have more than one attacker VM, use `attacker-vm2`, etc.)

3. **Start GoPhish**
   - Inside the VM, go to the attacker files folder:
     ```sh
     cd /opt/attacker
     ```
   - Start GoPhish using Docker Compose:
     ```sh
     docker-compose up -d
     ```
   - This will launch GoPhish in the background.

4. **Access the GoPhish Admin Panel**
   - On your own computer, open a web browser and go to:
     - [https://localhost:3333](http://localhost:3333) (Admin panel)
     - [https://localhost](http://localhost) (Phishing site)
   - Default GoPhish login: `admin` / `gophish` (unless changed in configuration)

5. **Using Templates**
   - The `templates/` folder is automatically available inside the VM at `/opt/attacker/templates`.
   - You can upload these templates into GoPhish via its web interface.

## Troubleshooting
- If you see errors about Docker, make sure Docker is installed and running inside the VM.
- If GoPhish does not start, try running `docker-compose down` and then `docker-compose up -d` again.
- If you cannot access the admin panel, check that the VM is running and ports are not blocked by your firewall.

---

No manual file copying or installation is needed—everything is automated!

