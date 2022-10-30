## Load settings applied with :set
## config for qutebrowser 

config.load_autoconfig()

## General config
c.content.default_encoding = 'utf-8'
c.content.javascript.enabled = True
c.content.local_storage = True
c.content.plugins = True

config.bind('zz', 'close')

c.content.proxy = ""


config.bind('<Ctrl-m>', 'spawn mpv {url} ;; message-info "Sending video to mpv..."')
config.bind('<Ctrl-Shift-m>', 'hint links spawn umpv {hint-url}')
config.bind(';M', 'hint --rapid links spawn umpv {hint-url}')

