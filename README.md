# Introduction 
TODO: Give a short introduction of your project. Let this section explain the objectives or the motivation behind this project. 

# Getting Started
Generate init-cfg.txt with variables:
    type=static
    ip-address={{ man_ip }}
    default-gateway={{ man_gateway }}
    netmask={{ man_mask }}
    dns-primary={{ man_dns1 }}
    dns-secondary={{ man_dns2 }}

Generate iso from folder structure

Deploy ISO to Cloud Director

Deploy PA image to VDC
    Set NIC 0 to Static Manual with {{ man_ip }}

Attach iso to image

Boot Image

Wait for config
    Validate config applied and firewall is responding

# Build and Test


# Contribute
