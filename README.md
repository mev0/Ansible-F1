# Proyecto de Automatización de Redes con Ansible – Fase 1

## Descripción

Este proyecto tiene como objetivo automatizar la configuración de una topología VPN Full-Mesh entre tres routers Cisco IOS utilizando Ansible.

La solución implementa:

* VPN GRE entre todos los routers.
* Protección de los túneles mediante IPSec con IKEv2.
* Enrutamiento dinámico mediante OSPF.
* Configuración automática utilizando playbooks y roles de Ansible.

El proyecto corresponde a la **Fase 1** de la asignatura, por lo que únicamente contempla la automatización con Ansible, sin integración CI/CD.

---

# Topología

La red está formada por tres routers Cisco IOS conectados entre sí mediante una topología Full-Mesh.

Cada router posee:

* Interfaces físicas para la comunicación entre routers.
* Una interfaz Loopback utilizada para comprobar el funcionamiento de OSPF.
* Dos túneles GRE protegidos con IPSec.

---

# Estructura del proyecto

```
/ansible-network
├── ansible.cfg
├── CONF ROUTERS.txt
├── Dockerfile
├── entrypoint.sh
├── group_vars
│   ├── all.yml
│   └── routers.yml
├── host_vars
│   ├── R1.yml
│   ├── R2.yml
│   └── R3.yml
├── inventory
│   └── hosts.ini
├── README.md
├── requirements.yml
├── roles
│   ├── base_config
│   │   └── tasks
│   │       └── main.yml
│   ├── routing_ospf
│   │   └── tasks
│   │       └── main.yml
│   ├── vpn_gre
│   │   └── tasks
│   │       └── main.yml
│   └── vpn_ipsec
│       └── tasks
│           └── main.yml
└── site.yml

```

## Descripción de los roles

**base_config**

Configura parámetros básicos del router.

**vpn_ipsec**

Configura IKEv2, Keyring, Transform Set y Profile IPSec.

**vpn_gre**

Crea los túneles GRE y aplica la protección IPSec.

**routing_ospf**

Configura el proceso OSPF y publica las redes correspondientes.

---

# Requisitos

* Ansible instalado.
* Colección `cisco.ios`.
* Acceso SSH a los routers Cisco IOS.
* Direccionamiento IP previamente configurado en las interfaces físicas.

---

# Ejecución

Desde el directorio del proyecto ejecutar:

```bash
ansible-playbook site.yml --ask-vault-pass -vvv
```

---

# Verificación

Para comprobar el funcionamiento de la automatización pueden utilizarse los siguientes comandos en los routers:

```
show ip interface brief | include Tunnel
show crypto session
show crypto ikev2 sa
show ip ospf neighbor
show ip route ospf
```

También es posible verificar la conectividad mediante:

```
ping 172.16.2.1
ping 172.16.3.1
```

En Wireshark se puede comprobar el cifrado del tráfico capturando sobre el enlace físico entre routers y aplicando el filtro:

```
esp
```

---

# Autor

Proyecto desarrollado para la asignatura de Automatización de Redes.

Fase 1 – Automatización mediante Ansible.

