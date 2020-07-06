# Ansible Check_MK

[![Maintenance](https://img.shields.io/maintenance/yes/2020.svg)](https://github.com/Madic-/ansible-check_mk) [![Build Status](https://travis-ci.org/Madic-/ansible-check_mk.svg?branch=master)](https://travis-ci.org/Madic-/ansible-check_mk)

The intention of this ansible role is to replicate some of the functionality from the [OMD](https://labs.consol.de/de/omd/) v2.X packages with focus on Check_MK RAW Edition. OMD hasn't updated Check_MK in years and finally removed it from version 3. So this role is going to install the following tools and pre-configure them:

* [x] [Check_MK RAW Edition](https://mathias-kettner.de)
  * [ ] Check_MK Master / Slave Configuration
  * [ ] Dual Graphing pnp4nagios and InfluxDB/Grafana
* [x] [Mod-Gearman](https://mod-gearman.org/)
* [x] [Thruk](https://www.thruk.org)
  * [x] Granting default Check_MK User administrative permission
  * [x] Pre-configuring Check_MK Site in Thruk
* [x] [Grafana](https://grafana.com)
  * [x] [Histou](https://github.com/Griesbacher/histou)
  * [x] Adding InfluxDB Nagflux datasource
* [x] [InfluxDB](https://www.influxdata.com)
  * [x] Pre-configuring Nagflux database
* [x] [Nagflux](https://github.com/Griesbacher/nagflux)

I assume you have a process in place to configure apache2 with a valid TLS configuration because by default all WebUIs are only accessible via http. A valid TLS configuration is out of scope of this role.

## Supported Operating Systems

* Ubuntu 18.04
* Debian 9

## Role Variables

All variables are defined in defaults/main.yml.

## Example Playbook

    ---
    - hosts: check_mk_server
      roles:
        - check_mk
      vars:
        - cmk_site_name: cmk

## Configuration Files

This role should be idempotent, like any other ansible role. Because of this I try to use locations for the configuration files which will not get overwritten when changing settings on the web interfaces of the different tools.

### Thruk

    /etc/thruk/menu_local.conf
    /etc/thruk/thruk_local.d/thruk_ansible.conf

Configurations located beneath /etc/thruk/thruk_local.d will not be shown in the Thruk WebUI, e.g. the backend configuration. If I would use /etc/thruk/thruk_local.conf changes done in the Thruk WebUI would get overwritten when running the role again.

#### Grafana

    /etc/grafana/provisioning/datasources/influxdb-nagflux.yml

Provisioning file for the nagflux database.

### Apache2

    /etc/apache2/conf-enabled/grafana.conf
    /etc/apache2/conf-enabled/histou.conf

## Using Check_MK Users in Thruk

By default no user, except for the user created through this role, has permissions to access any information from within Thruk. To give another user permissions use the Config Tool --> "User Settings" or "CGI & Access" options.

## Tests

It's possible to test the role against a docker container. The provided test script must be run from the root of the role. By providing environment variables you can slightly modify the behaviour of the script.

    DISTRO=debian9 ./tests/test.sh
    APT_CACHER_ENABLED=true APT_CACHER_URL=http://10.59.100.229:3142/ CLEANUP=false ./tests/test.sh

The following environment variables are availables:

| Variable           | Values                     | Usage                                                         |
| ------------------ | -------------------------- | ------------------------------------------------------------- |
| APT_CACHER_ENABLED | true<br>**false**          | Enable apt-cacher-ng usage                                    |
| APT_CACHER_URL     | http://apt-cacher-ng:3142/ | URL to the apt-cacher-ng proxy                                |
| CLEANUP            | **true**<br>false          | Should the docker container at the end be stopped and removed |
| DISTRO             | **ubuntu1804**<br>debian9  | Distribution to test against                                  |