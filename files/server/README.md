# Server VM: Axigen Mail Server Setup Guide

This folder contains everything needed to run the Axigen mail server inside the server VM. Axigen provides email services for the phishing lab and is used by GoPhish to send simulated phishing emails.

## What Happens Automatically?
- All files in this folder (including `docker-compose.yml`) are automatically copied to the server VM when you start the lab—no manual copying is needed.
- Axigen is set up using Docker, so you do not need to install anything manually.

## How to Start Axigen (Step-by-Step)

1. **Start the Lab**
   - In the main project folder, run:
     ```sh
     vagrant up
     ```
   - This will create and configure all VMs, including the server VM.

2. **Access the Server VM**
   - Enter the server VM by running:
     ```sh
     vagrant ssh server-vm-1
     ```
   - (If you have more than one server VM, use `server-vm-2`, etc.)

3. **Start Axigen Mail Server**
   - Inside the VM, go to the server files folder:
     ```sh
     cd /opt/server
     ```
   - Start Axigen using Docker Compose:
     ```sh
     docker-compose up -d
     ```
   - This will launch Axigen in the background.

4. **Accessing Axigen Web Interfaces**
   - On your own computer, open a web browser and go to:
     - [http://localhost:80](http://localhost:80) (WebMail)
     - [https://localhost:443](https://localhost:443) (WebMail, secure)
     - [https://localhost:9443](https://localhost:9443) (WebAdmin)
   - Default admin login: `admin` / `admin123`

5. **Setting Up for GoPhish**
   - GoPhish will use Axigen to send emails. Use the following SMTP settings in GoPhish:
     - SMTP Server: `server-vm-1` or `localhost` (if running from inside the VM)
     - Port: `25`, `465`, or `587` (as needed)
     - Username/Password: Use the credentials you set up in Axigen (default admin is `admin` / `admin123`)
   - You may need to create user mailboxes in Axigen for your phishing campaigns. This can be done via the WebAdmin interface.

## Troubleshooting
- If you see errors about Docker, make sure Docker is installed and running inside the VM.
- If Axigen does not start, try running `docker-compose down` and then `docker-compose up -d` again.
- If you cannot access the web interfaces, check that the VM is running and ports are not blocked by your firewall.
- For more help, see the official [Axigen documentation](https://www.axigen.com/documentation/).

---

No manual file copying or installation is needed—everything is automated!

