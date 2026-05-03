# Ansible — Configuración de servidores

Automatización de configuración para los servidores EC2 del proyecto
aws-ha-webapp usando roles Ansible.

---

## Requisitos

- Ansible >= 2.12
- Python >= 3.8
- Colección `amazon.aws` instalada
- Credenciales AWS configuradas (`aws configure`)
- Llave privada SSH en `~/.ssh/p01-webha-key`
- Bastion Host desplegado y accesible

### Instalar la colección de AWS

```bash
ansible-galaxy collection install amazon.aws
```

---

## Estructura

```
ansible/
├── ansible.cfg              # Configuración general y proxy SSH via Bastion
├── playbook.yml             # Playbook principal
├── inventory.aws_ec2.yml    # Inventario dinámico por tags EC2
├── group_vars/
│   ├── dev.yml              # Variables para entorno dev
│   └── prod.yml             # Variables para entorno prod
└── roles/
    ├── common/              # Configuración base del servidor
    ├── webserver/           # Instalación y configuración de Nginx
    └── deploy/              # Despliegue de la aplicación estática
```

---

## Roles

### common
Prepara el servidor base: actualiza paquetes, instala utilitarios
y configura el timezone a America/Bogota.

### webserver
Instala Nginx, aplica la configuración personalizada, configura
el firewall local y asegura que el servicio esté activo y habilitado.

### deploy
Despliega la aplicación web estática usando el módulo template
de Ansible. Reemplaza ansible_hostname con el hostname
real de cada servidor.

---

## Cómo ejecutar

### 1. Verificar conectividad con los servidores

```bash
ansible all -m ping
```

### 2. Ver qué servidores detecta el inventario dinámico

```bash
ansible-inventory --list
```

### 3. Ejecutar el playbook completo

```bash
ansible-playbook playbook.yml
```

### 4. Ejecutar solo un rol específico

```bash
ansible-playbook playbook.yml --tags common
ansible-playbook playbook.yml --tags webserver
ansible-playbook playbook.yml --tags deploy
```

### 5. Verificar idempotencia

Correr el playbook dos veces seguidas. La segunda ejecución
debe mostrar todo en verde sin ningún changed.

```bash
ansible-playbook playbook.yml
ansible-playbook playbook.yml
```

---

## Variables por entorno

Las variables se separan por entorno en group_vars/.
Para usar el entorno prod:

```bash
ansible-playbook playbook.yml -e "env=prod"
```

---

## Notas

- Los roles son idempotentes por diseño — pueden ejecutarse
  múltiples veces sin efectos secundarios.
- El inventario dinámico descubre automáticamente las instancias
  EC2 con el tag Project=p01-webha en estado running.
- La conexión SSH a los servidores privados se realiza a través
  del Bastion Host configurado en ansible.cfg.
