#Description
- distributed load testing tool
- communicate in the cluster using Consul
- atomic tsung configuration achiveved by using consul-template https://github.com/hashicorp/consul-template 

#Setup

- open all port range: 0-65536
- kernel tuning, edit `/etc/sysctl.conf`

```
fs.file-max = 9999999
fs.nr_open = 9999999
net.core.netdev_max_backlog = 4096
net.core.rmem_max = 16777216
net.core.somaxconn = 65535
net.core.wmem_max = 16777216
net.ipv4.ip_forward = 0
net.ipv4.ip_local_port_range = 1025 65535
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_keepalive_time = 30
net.ipv4.tcp_max_syn_backlog = 20480
net.ipv4.tcp_max_tw_buckets = 400000
net.ipv4.tcp_no_metrics_save = 1
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1
vm.min_free_kbytes = 65536
vm.overcommit_memory = 1

```

- `sudo sysctl -p`

```
./setup-tsung.sh
```

- generate a RSA key-pair
- save the private key at `/home/ubuntu/.ssh/id_rsa`
- `ubuntu` user should have all permission on `.ssh` 
- `ssh <slave_ip>` should be ok without prompting anything
- install consul
- bootstrap consul server

```
./start-consul.sh
```

- install `consul-template`
- create a template `tsung.tpl`
- setup SSH configuration

```
vim /home/ubuntu/.ssh/config
```

```
Host *
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
```

```
consul-template -template "tsung.tpl:tsung.xml"
```

- on tsung slave, modify `/etc/hosts`

```
<tsung_master_ip> tsungmaster
``` 

- start consul member and ask them join the `tsungmaster`
- debug `consul members`

#Usage

- you should be able to run as `ubuntu` user
- `tsung -f tsung.xml -k start`
- open your browser at: `<tsung_master_host>:8091` to view the report

#Contact
- Binh Nguyen
