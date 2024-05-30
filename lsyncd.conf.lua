 settings {

        logfile = "/var/log/lsyncd/lsyncd.log",
        statusFile = "/var/log/lsyncd/lsyncd.status",
        statusInterval= 1,
        nodaemon = false,
}

sync {
default.rsyncssh,
        source = "/home",
        host    ="192.168.xxx.xxxx",
        targetdir = "/home/backupdev",
        delay = 5,
        rsync = { rsh="/usr/bin/ssh -l hardy -i /home/user/.ssh/id_rsa -o StrictHostKeyChecking=no"}
}
