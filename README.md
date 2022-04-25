# Iquall Networks Challenge

Consola de monitoreo con Prometheus, representado graficamente con Grafana

## Requisitos previos
  1. Nodo controlador
      + Servidor con ansible instalado.
        * python >= 2.7
        * ssh
  2. Nodos a monitorear
     + python >= 2.6
       * Si el servidor a monitorear no tiene python, se puede hacer uso del modulo raw de ansible para instalar python
       ```bash 
       # ansible myhost --become -m raw -a "apt/yum install -y python2" 
       ```
**NOTA:** *Ansible puede correrse en un servidor separado que configure el nodo controlador y los nodos a monitorear*

  [Documentacion:](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## Pasos para la implementación:
  1. Descomprimir el archivo iquallNetworksChallenge.tar.gz
  ```bash
  $ tar -xzvf iquallNetworksChallenge.tar.gz -C [directorio-destino]
  ```
  2. Editar el archivo inventory.yml para definir el nodo controlador y los nodos a monitorear. Reemplazar las xxx por numeros ips reales.
  ```bash
  $ vim inventory.yml 
  ```
  ```bash
  all:
  vars:
    ansible_python_interpreter: /usr/bin/python3
  children:
    monitor:
      hosts:
        **xxx.xxx.xxx.xxx**

    hosts:
      hosts:
        **xxx.xxx.xxx.xxx**
        ...
        ...
  ```
  3. Ejecutar el siguiente comando y esperar a que se configure el ambiente definido en el punto anterior.
  ```bash
  $ make install
  ```
### Resultado

**nodo controlador:** prometheus/grafana + node-exporter

**nodo/s a monitorear:** node-exporter

## Consola de monitoreo Grafana

Abrir un navegador y escribir [ip-controlador]:3000

**usuario:** *admin*

**contraseña:** *challenge*
  
### Agregar dashboards
Una vez logueado en Grafana en la barra vertical de la derecha hay un icono +, al pasar el mouse arriba se despliega un menu, seleccionar **Import**. 
En esta pantalla nos da la opcion de agregar un json o un id.

En la siguiente pagina [Grafana Dashboards](https://grafana.com/grafana/dashboards/) se puede buscar un dasboard, copiar su ID y pegarlo. Automagicamente se despliega el dasboard completo.

## Configuración
### Modificar version node-exporter
Editar archivo: /roles/node-exporter/defaults/main.yml y modificar el valor de **node_exporter_version** por la version 
que se desee. Guardar y volver a ejecutar **make install**

```bash
$ vim /roles/node-exporter/defaults/main.yml
```
```bash
node_exporter_version: "1.3.1"
node_exporter_bin: /usr/local/bin/node_exporter
node_exporter_user: node-exporter
node_exporter_group: "{{ node_exporter_user }}"
node_exporter_dir_conf: /etc/node_exporter
```


## Links relacionados
[github node-exporter](https://github.com/prometheus/node_exporter/releases)

[prometheus node-exporter](https://prometheus.io/docs/guides/node-exporter/)

[prometheus](https://prometheus.io/docs/prometheus/latest/installation/)

[Grafana Dashboards](https://grafana.com/grafana/dashboards/)

[virtual venv](https://www.redhat.com/sysadmin/python-venv-ansible)







