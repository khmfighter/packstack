#!/bin/bash
if [ $(id -u) != 0 ]; then
    SUDO='sudo'
fi

echo -e "Generating packstack config for:
- keystone
- glance (swift backend)
- nova
- neutron (ovs+vxlan)
- swift
- sahara
- trove
- tempest (regex: 'smoke dashboard')"
echo "tempest will run if packstack's installation completes successfully."
echo

$SUDO packstack --allinone \
          --debug \
          --service-workers=2 \
          --default-password="packstack" \
          --os-aodh-install=n \
          --os-ceilometer-install=n \
          --os-gnocchi-install=n \
          --os-cinder-install=n \
          --os-horizon-install=n \
          --nagios-install=n \
          --glance-backend=swift \
          --os-sahara-install=y \
          --os-trove-install=y \
          --provision-demo=y \
          --provision-tempest=y \
          --run-tempest=y \
          --run-tempest-tests="smoke" || export FAILURE=true
