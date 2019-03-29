# Ansible Check_MK

[![Maintenance](https://img.shields.io/maintenance/yes/2019.svg)](https://github.com/Madic-/ansible-check_mk)

[![Build Status](https://travis-ci.org/Madic-/ansible-check_mk.svg?branch=master)](https://travis-ci.org/Madic-/ansible-check_mk)

The intention of this ansible role is to replicate some of the functionality from the [OMD](https://labs.consol.de/de/omd/) v2.X packages with focus on Check_MK RAW. OMD hasn't updated Check_MK in years and finally removed it from version 3. So this role is going to install the following tools and pre-configure them:

* [x] [Check_MK RAW](https://mathias-kettner.de/)
  * [ ] Check_MK Master / Slave Configuration
* [x] [Thruk](https://www.thruk.org)
  * [ ] Using Check_MK Users
* [ ] [Grafana](https://grafana.com/)
  * [ ] [Histou](https://github.com/Griesbacher/histou)
  * [ ] Dual Graphing pnp4nagios and InfluxDB/Grafana
* [ ] [InfluxDB](https://www.influxdata.com/)
* [ ] [Nagflux](https://github.com/Griesbacher/nagflux)

I assume you have a process in place to configure apache2 with a valid TLS configuration because by default all WebUIs are only accessible via http. A valid TLS configuration is out of scope of this role.

## Supported Operating Systems

* Ubuntu 18.04
* Debian 9

## Configuration Files

This role should be idempotent, like any other ansible role. Because of this I try to use locations for the configuration files which will not get overwritten when changing settings on the web interfaces of the different tools.

### Thruk

```
/etc/thruk/thruk_local.d/
```

Configurations located beneath this folder will not be shown in the Thruk WebUI, e.g. the backend configuration. But the other configuration files will get overwritten when changing settings through the Thruk WebUI.