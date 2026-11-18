# Trabajo Práctico Integrador – Arquitectura y Sistemas Operativos (UTN - TUPaD)

## 📌 Tema
**Seguridad en Sistemas Operativos:** Control de acceso discrecional (POSIX), gestión de privilegios (`sudo`) y auditoría de eventos a nivel de kernel (`auditd`) en Ubuntu Server Linux.

## 👤 Integrante
* **Waldo Martín González** – `waldo.gonzalez@tupad.utn.edu.ar`

## 🖥️ Entorno de Pruebas (Servidor Real: *hivemind*)
* **Hardware:** Servidor doméstico de bajos recursos (2 núcleos CPU, 3.9 GB de RAM, disco de sistema de 57 GB y almacenamiento `/datos` de 314 GB).
* **Sistema Operativo:** Ubuntu Server 24.04.4 LTS (GNU/Linux `6.8.0-149-generic`, sin entorno gráfico, administrado vía SSH).
* **Contexto productivo:** Aloja 31 contenedores Docker en simultáneo (videovigilancia con Frigate a través de Tailscale, proxy inverso Caddy, automatizaciones con n8n, bots con conexión directa a Telegram y un agente de IA en la nube) operando a ~40 °C y 59% de uso de RAM.
* **Herramientas utilizadas:** Bash, `chmod`, `chown`, `useradd`, `sudo` y `auditd` (`auditctl`, `augenrules`, `ausearch`).

## 📂 Contenido del Repositorio
* `TPI_Seguridad_AYSO_Waldo_Martin.pdf`: Informe técnico completo en formato PDF (con marco teórico, metodología, resultados, conclusiones y bibliografía APA).
* `setup_seguridad.sh`: Script Bash comentado que automatiza la instalación de `auditd`, creación de usuario de prueba, configuración de permisos `600` y reglas persistentes de auditoría.
* **Capturas de pantalla:** Evidencia de la verificación de permisos (`ls -la`), bloqueo de lectura y `sudo`, y logs forenses del kernel (`ausearch`).

## 🚀 Cómo ejecutar el caso práctico
```bash
chmod +x setup_seguridad.sh
./setup_seguridad.sh

# Pruebas de verificación y auditoría
ls -la /seguro/datos.txt
sudo -u usuario1 cat /seguro/datos.txt
sudo -u usuario1 sudo ls /root
sudo ausearch -k acceso_datos -i
