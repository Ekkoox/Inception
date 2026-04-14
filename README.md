# Inception @42Paris

This project has been created as part of the 42 curriculum by enschnei.

# Description

The Inception project is a systemic introduction to virtualization using Docker. The goal is to set up a small infrastructure of interconnected services (NGINX, MariaDB, and WordPress) within a managed Docker environment. This project focuses on container orchestration, security, and the "System Administration" aspect of web infrastructure.

# Project Description & Design Choices

# Use of Docker

Docker is used here to containerize each service, ensuring that they run in isolated environments while sharing the host's OS kernel. This allows for a lightweight, portable, and reproducible infrastructure.

# Design Choices

- Base Image: All containers are built from Debian Bullseye to ensure stability and control over installed packages.

- PID 1: Each service (NGINX, MariaDB, PHP-FPM) is launched as the primary process to handle signals correctly.

- Automation: WordPress is fully automated via WP-CLI to avoid any manual configuration during the evaluation.

Technical Comparisons

# Technical Comparisons

# Instructions

