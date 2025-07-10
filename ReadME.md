# master-server-modules scripts

This directory contains various scripts to manage, deploy, and monitor services for the master-server-modules project. Below is a summary of each script and its purpose.

## Summary Table

| Script Name            | Description                                      |
|------------------------|--------------------------------------------------|
| start-all.sh           | Starts all major services in sequence.           |
| start-website.sh       | Starts the website service.                      |
| start-vkid-gpt.sh      | Starts the vkid-gpt service.                     |
| start-master.sh        | Builds and runs the master-server Docker service.|
| start-ssh-tunnels.sh   | Establishes SSH tunnels for port forwarding.     |
| vkid-logs.sh           | Tails logs for the vkid-gpt service.             |
| restart-slaves.sh      | Restarts and redeploys slave Docker containers.  |

---

## Script Details

### start-website.sh
Starts the website service by navigating to the `archi-website` directory and running `setup-website.sh`.

**Usage:**
```bash
./start-website.sh
```

---

### start-vkid-gpt.sh
Stops any running vkid-gpt Python processes, pulls the latest code, activates the virtual environment, and starts the vkid-gpt service in the background.

**Usage:**
```bash
./start-vkid-gpt.sh
```

---

### start-master.sh
Stops and removes any existing `master-server` Docker container, pulls the latest code, builds the Docker image, and runs the container on port 8001.

**Usage:**
```bash
./start-master.sh
```

---

### start-all.sh
Runs all major startup scripts in sequence: master server, SSH tunnels, vkid-gpt, and website.

**Usage:**
```bash
./start-all.sh
```

---

### start-ssh-tunnels.sh
Establishes SSH tunnels for ports 8080, 8160, and 8240 to a remote server using `autossh`. Checks if the ports are already forwarded before starting new tunnels.

**Usage:**
```bash
./start-ssh-tunnels.sh
```

---

### vkid-logs.sh
Tails the `nohup.out` log file for the vkid-gpt service.

**Usage:**
```bash
./vkid-logs.sh
```

---

### restart-slaves.sh
Stops and removes all Docker containers and images, pulls the latest images for `skvis`, `fpgen`, and `rembg`, and starts them with the appropriate environment variables and port mappings.

**Usage:**
```bash
./restart-slaves.sh
```

---

## Notes
- Ensure you have the necessary permissions to execute these scripts (`chmod +x scriptname.sh`).
- Some scripts require Docker, Python, and other dependencies to be installed and configured.
- SSH tunnels require `autossh` and key-based authentication to be set up.