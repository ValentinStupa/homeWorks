variable hardware {
    type = map()
    default = {
        platform-web = {
            cores           = 2
            memory          = 1
            core_fraction   = 5
        },
        platform-db = {
            cores           = 2
            memory          = 1
            core_fraction   = 5
        }
    }
}
