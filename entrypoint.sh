#!/bin/bash

echo "=================================="
echo " Contenedor Ansible iniciado"
echo "=================================="

# Configuración automática de red Docker
ip addr add 192.168.0.1/24 dev eth0 2>/dev/null || true
ip link set eth0 up 2>/dev/null || true

echo "[OK] IP 192.168.0.1 configurada en eth0"

exec /bin/bash
