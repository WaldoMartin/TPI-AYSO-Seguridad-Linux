#!/bin/bash
# Script de automatización: Control de acceso y auditoría en Linux
# Materia: Arquitectura y Sistemas Operativos (UTN - TUPaD)
# Alumno: Waldo Martín González

set -e

echo "[1/5] Instalando y habilitando auditd..."
sudo apt update && sudo apt install -y auditd audispd-plugins
sudo systemctl enable --now auditd

echo "[2/5] Creando usuario de prueba sin privilegios (usuario1)..."
if ! id "usuario1" &>/dev/null; then
    sudo useradd -m -s /bin/bash usuario1
    echo "usuario1:ClavePrueba123!" | sudo chpasswd
fi

echo "[3/5] Creando directorio y archivo confidencial..."
sudo mkdir -p /seguro
echo "CONFIDENCIAL: Datos sensibles del sistema." | sudo tee /seguro/datos.txt > /dev/null
sudo chown root:root /seguro/datos.txt
sudo chmod 600 /seguro/datos.txt

echo "[4/5] Configurando regla persistente de auditoría..."
echo "-w /seguro/datos.txt -p rwxa -k acceso_datos" | sudo tee /etc/audit/rules.d/seguridad_tp.rules > /dev/null
sudo augenrules --load

echo "[5/5] Verificación de reglas activas:"
sudo auditctl -l
echo "Configuración finalizada con éxito."
