# someshtarra-LINUX_SHELL_SCRIPT
linux

## 🐧 My Daily Linux Command Wheel

I actively use Linux commands in my daily Cloud, DevOps, AWS, server administration, troubleshooting, deployment, and real-time project workflows. The commands below represent the core toolkit I use in production environments.

<p align="center">
  <img src="./assets/linux-command-wheel.svg" alt="Daily Linux Command Wheel" width="100%" />
</p>

> 🐧 **Linux is the backbone of my engineering workflow.** From accessing EC2 instances and troubleshooting deployments with Tomcat and Jenkins, to inspecting system logs and managing Docker/Kubernetes containers—these are the real-world commands I rely on to keep production systems running smoothly.

### 💻 Real-Time Project Workflow

```bash
$ ssh -i project-key.pem ec2-user@server
$ cd /var/log
$ tail -f app.log
$ grep -i "error" app.log
$ df -h
$ free -h
$ ps aux | grep java
$ ss -tulpn
$ sudo systemctl status tomcat
$ sudo journalctl -u tomcat -n 100
$ curl -I http://localhost:8080
$ git pull origin main
$ sudo systemctl restart tomcat
```

### 📊 Real-Project Command Reference

| Area | Daily / frequent real-project commands | Real use |
| :--- | :--- | :--- |
| **Navigation** | `pwd`, `ls -lah`, `cd` | Move around servers and inspect files |
| **Files** | `cp`, `mv`, `rm`, `mkdir`, `touch` | Manage configs, builds, backups |
| **Read logs** | `cat`, `less`, `head`, `tail -f` | Inspect application and system logs |
| **Search** | `grep`, `find`, `awk`, `sed` | Find errors and process output |
| **Processes** | `ps aux`, `top`, `htop`, `pgrep` | Diagnose CPU/process issues |
| **Disk** | `df -h`, `du -sh`, `lsblk`, `df -Th` | Troubleshoot disk-full problems |
| **Memory** | `free -h`, `vmstat` | Check RAM and system pressure |
| **Services** | `systemctl`, `journalctl` | Start/restart/debug services |
| **Network** | `curl`, `ping`, `ss -tulpn`, `ip addr` | Test APIs, ports, networking |
| **Remote** | `ssh`, `scp`, `rsync` | Access servers and transfer files |
| **Permissions** | `chmod`, `chown`, `sudo` | Fix access and ownership |
| **Archives** | `tar`, `gzip`, `unzip` | Deployments and backups |
| **Git workflow** | `git status`, `git pull`, `git add`, `git commit`, `git push`, `git log` | Daily source-control workflow |
| **Containers** | `docker ps`, `docker logs`, `docker exec`, `docker compose` | Container operations |
| **Kubernetes** | `kubectl get`, `kubectl logs`, `kubectl describe`, `kubectl exec` | Cluster troubleshooting |
| **Shell** | `history`, `echo`, `export`, `env`, `which` | Environment and command debugging |
