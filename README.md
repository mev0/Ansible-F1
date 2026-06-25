# Proyecto de Automatización de Redes - Fase 1

Este proyecto utiliza Ansible para automatizar la configuración de una topología VPN Full-Mesh (IPSec + GRE) con enrutamiento OSPF en tres routers Cisco IOS.

## Estructura del Proyecto

- `inventory/hosts.ini`: Definición de los routers y sus IPs de gestión.
- `group_vars/`: Variables compartidas (configuración de conexión, OSPF, etc.).
- `host_vars/`: Configuraciones específicas de cada router (túneles, redes OSPF local).
- `roles/`:
    - `base_config`: Configura hostname y dominio.
    - `vpn_ipsec`: Configura políticas IKEv2 y perfiles IPSec.
    - `vpn_gre`: Configura las interfaces Tunnel con protección IPSec.
    - `routing_ospf`: Configura el proceso OSPF y las redes a anunciar.
- `site.yml`: Playbook principal.
- `ansible.cfg`: Configuración por defecto de Ansible.

## Requisitos

- Ansible instalado en la máquina de control.
- Conectividad SSH a los routers (configurada en la fase 0/base).
- Los routers deben tener las direcciones IP físicas ya configuradas (G0/1, G0/2).

## Uso

1.  Asegúrate de que las IPs en `inventory/hosts.ini` sean correctas.
2.  El archivo `group_vars/vault.yml` contiene la contraseña `Ansible123`. Se recomienda encriptarlo antes de usar:
    ```bash
    ansible-vault encrypt group_vars/vault.yml
    ```
3.  Ejecuta el playbook:
    ```bash
    ansible-playbook site.yml
    ```

## Verificación

Una vez ejecutado, puedes verificar la conectividad con:
- `show crypto ikev2 sa`
- `show ip interface brief | include Tunnel`
- `show ip route ospf`
- `ping 172.16.x.x` (Loopback de otro router)
