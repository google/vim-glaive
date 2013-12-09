Glaive is a utility for configuring maktaba plugins. It turns this:

    :let g:myplugin\_enablefeature = 1
    :let g:myplugin\_defaultdir = $HOME
    :let g:myplugin\_weirdmode = 'm'

into this:

    :Glaive myplugin enablefeature defaultdir=`$HOME` weirdmode='m'

In order for this to work, the plugin must use the maktaba flag API. Any plugin
using the flag API can be configured by glaive.

[Maktaba](http://github.com/google/maktaba) is a vimscript library for plugin
authors. It handles parsing the setting syntax, looking up the plugins, and
applying the settings. Glaive itself is merely a thin wrapper around the hooks
that maktaba provides: any plugin can sport a similar interface with minimal
effort. Plugin manager plugins in particular are encouraged to do so.

For details, see the executable documentation in the `vroom/` directory or the
helpfiles in the `doc/` directory. The helpfiles are also available via
`:help glaive` if Glaive is installed (and helptags have been generated).
