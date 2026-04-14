*This project has been created as part of the 42 curriculum by enschnei.*

## Description

The Inception project is a systemic introduction to virtualization using Docker. The goal is to set up a small infrastructure of interconnected services (NGINX, MariaDB, and WordPress) within a managed Docker environment. This project focuses on container orchestration, security, and the "System Administration" aspect of web infrastructure.

## Project Description & Design Choices

### Use of Docker

Docker is used here to containerize each service, ensuring that they run in isolated environments while sharing the host's OS kernel. This allows for a lightweight, portable, and reproducible infrastructure.

### Design Choices

- Base Image: All containers are built from Debian Bullseye to ensure stability and control over installed packages.

- PID 1: Each service (NGINX, MariaDB, PHP-FPM) is launched as the primary process to handle signals correctly.

- Automation: WordPress is fully automated via WP-CLI to avoid any manual configuration during the evaluation.

### Technical Comparisons

| Feature                | Comparison & Choice |
| ---------------------- | ------------------- |
| VM vs Docker           | Docker is much more lightweight than a VM. A VM virtualizes the                             entire hardware and runs a full OS, whereas Docker shares the                               host kernel, making it faster to start and less resource-                                   intensive.        |
| Secrets vs Env Vars    | Environment Variables (used here via .env) are easier to                                    implement for this scale. Secrets are more secure (stored in                                /run/secrets) but often require Docker Swarm or Kubernetes for                               full potential.        |
| Docker vs Host Network | We use a Docker Network (bridge mode). Unlike the host network,                             it provides isolation; services only communicate with each                                  other, and only NGINX is exposed to the outside world.        |
| Volumes vs Bind Mounts | We use Docker Volumes. Unlike Bind Mounts, which depend on the                              host's file structure, Volumes are managed by Docker, providing                             better performance and portability between different OS.        |

### Instructions

#### 1. Host Configuration

Add the following line to your /etc/hosts:

```c
127.0.0.1  enschnei.42.fr
```
#### 2. Setup

1. Clone the repository.
2. Create your .env file in srcs/ (based on srcs/.env_template).
3. Run the following command at the root of the project:

```c
make
```
#### 3. Usage

- Access the website: https://enschnei.42.fr

## Resources

### Documentation

- [Docker docs](https://docs.docker.com/)
- [NGINX guide](https://nginx.org/en/docs/beginners_guide.html)
- [Wordpress Documentation](https://developer.wordpress.org/advanced-administration/)
-
-

### Use of AI

Gemini (AI) was used as a collaborative peer for the following tasks:

- Organisation of the tasks: Find a plan to approach the project
- 
-
- Documentation: Structuring and translating this README to ensure it meets the project's requirements.
