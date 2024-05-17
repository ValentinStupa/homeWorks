variable hardware {
    type = map
    default = {
        platform-web = {
            cores           = 2
            memory          = 1
            core_fraction   = 5
        },
        platform-db = {
            cores           = 2
            memory          = 2
            core_fraction   = 20
        }
    }
}

variable metadata {
    type = map
    default = {
        serial-port-enable = 1
        ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEI4AI6/iSUW6k+H8SU5AW7z4wxVZooyapkkXa88tuL2"
    }  
}