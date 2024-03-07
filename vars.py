import jinja2

def translate(variables,working_dir):
    env = jinja2.Environment(loader=jinja2.FileSystemLoader(f"{working_dir}"))
    template = env.get_template('tf_variables.txt')
    out_template = template.render(
        vcd_url=variables.get('vcd_url'),
        vcd_org=variables.get('vcd_org'),
        vcd_vdc=variables.get('vcd_vdc'),
        catalog_org=variables.get('catalog_org'),
        catalog_name=variables.get('catalog_name'),
        template_name=variables.get('template_name'),
        vm_name=variables.get('vm_name'),
        man_net_name=variables.get('man_net_name'),
        man_ip=variables.get('man_ip'),
        inet_net_name=variables.get('inet_net_name'),
        inet_ip=variables.get('inet_ip'),
        dmz_net_name=variables.get('dmz_net_name'),
        dmz_ip=variables.get('dmz_ip'),
        int_net_name=variables.get('int_net_name'),
        int_ip=variables.get('int_ip')
    )
    with open(f"{working_dir}autoVars.tfvars", "w") as fh:
        fh.write(out_template)
    template2 = env.get_template('ansible_variables.txt')
    out_template = template2.render(
        vcd_url=variables.get('vcd_url'),
        vcd_org=variables.get('vcd_org'),
        vcd_vdc=variables.get('vcd_vdc'),
        vm_name=variables.get('vm_name'),
        catalog_org=variables.get('catalog_org'),
        catalog_name=variables.get('catalog_name'),
        secret_path=variables.get('secret_path'),
        working_directory=working_dir,
        man_ip=variables.get('man_ip'),
        man_subnet=variables.get('man_subnet'),
        man_gw=variables.get('man_gw'),
        man_cidr=variables.get('man_cidr'),
        inet_ip=variables.get('inet_ip'),
        inet_cidr=variables.get('inet_cidr'),
        inet_gw=variables.get('inet_gw'),
        inet_vlan=variables.get('inet_vlan'),
        dmz_vlan=variables.get('dmz_vlan'),
        int_vlan=variables.get('int_vlan'),
        u_account_id=variables.get('u_account_id'),
        palo_ver=variables.get('palo_ver'),
        time_zone=variables.get('time_zone'),
        site_code=variables.get('site_code'),
        location=variables.get('location')
    )
    with open(f"{working_dir}inputs.yml", "w") as fh:
        fh.write(out_template)
    template3 = env.get_template('init.txt')
    out_template = template3.render(
        man_ip=variables.get('man_ip'),
        man_gw=variables.get('man_gw'),
        man_subnet=variables.get('man_subnet'),
        man_dns1=variables.get('man_dns1'),
        man_dns2=variables.get('man_dns2')
    )
    with open(f"{working_dir}/iso/config/init-cfg.txt", "w") as fh:
        fh.write(out_template)