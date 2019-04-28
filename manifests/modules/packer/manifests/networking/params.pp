class packer::networking::params {

  case $::osfamily {
    debian: {
      $udev_rule     = '/etc/udev/rules.d/70-persistent-net.rules'
      $udev_rule_gen = '/lib/udev/rules.d/75-persistent-net-generator.rules'
    }

    redhat: {
      case $::operatingsystemrelease {
        '7.0', '7.0.1406', '7.1.1503', '7.2.1511', '7.2', '7.3.1611', '7.4.1708', '7.5.1804', '7.5', '7.6': {
          case $::provisioner {
            'virtualbox': { $interface_script = '/etc/sysconfig/network-scripts/ifcfg-enp0s3' }
            'vmware':     { $interface_script = '/etc/sysconfig/network-scripts/ifcfg-ens33' }
            'libvirt':    { $interface_script = '/etc/sysconfig/network-scripts/ifcfg-eth0' }
          }

          $udev_rule     = '/etc/udev/rules.d/70-persistent-net.rules'
          $udev_rule_gen = '/lib/udev/rules.d/75-persistent-net-generator.rules'
        }

        '5.10', '5.11': {
          $interface_script = '/etc/sysconfig/network-scripts/ifcfg-eth0'
          $udev_rule        = '/etc/udev/rules.d/70-persistent-net.rules'
        }

        '25', '26', '27', '28': {
          case $::provisioner {
            'virtualbox': { $interface_script = '/etc/sysconfig/network-scripts/ifcfg-enp0s3' }
            'libvirt':    { $interface_script = '/etc/sysconfig/network-scripts/ifcfg-ens4' }
            'vmware':     { $interface_script = '/etc/sysconfig/network-scripts/ifcfg-lo' }
          }
          $udev_rule     = undef
          $udev_rule_gen = undef
        }
        '29': {
          $interface_script = undef
          $udev_rule        = undef
          $udev_rule_gen    = undef
        }

        default: {
          $interface_script = '/etc/sysconfig/network-scripts/ifcfg-eth0'
          $udev_rule        = '/etc/udev/rules.d/70-persistent-net.rules'
          $udev_rule_gen    = '/lib/udev/rules.d/75-persistent-net-generator.rules'
        }
      }
    }
    suse: {
      $interface_script = '/etc/sysconfig/network/ifcfg-eth0'
      $udev_rule        = '/etc/udev/rules.d/70-persistent-net.rules'
      $udev_rule_gen    = '/lib/udev/rules.d/75-persistent-net-generator.rules'
    }
    solaris: {
      $udev_rule        = undef
      $udev_rule_gen    = undef
      $interface_script = undef

    }
    default: {
      fail( "Unsupported platform: ${::osfamily}/${::operatingsystem}" )
    }
  }

}
