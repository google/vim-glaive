Glaive is a utility for configuring maktaba plugins. It turns this:

    :let g:myplugin_enablefeature = 1
    :let g:myplugin_defaultdir = $HOME
    :let g:myplugin_weirdmode = 'm'

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

# Usage example

This example uses [Vundle](https://github.com/gmarik/vundle), whose
plugin-adding command is `Bundle`.

The example maktaba plugin is
[helloworld](https://github.com/google/maktaba/tree/master/examples/helloworld),
from the maktaba examples directory.

We will use Glaive to enable mappings and set the `name` option to "Bram".

```vim
" Add maktaba and glaive to the runtimepath.
" (The latter must be installed before it can be used.)
Bundle 'google/maktaba'
Bundle 'google/glaive'
call glaive#Install()

" Add helloworld to the runtime path.  (Normally this would be done with another
" Bundle command, but helloworld doesn't have a repository of its own.)
call maktaba#plugin#Install(maktaba#path#Join([maktaba#Maktaba().location,
    \ 'examples', 'helloworld']))

" Configure helloworld using glaive.
Glaive helloworld plugin[mappings] name='Bram'
```

Try it out!  `<Leader>Hh` should say `Hello, Bram!`, and `<Leader>Hg` should say
`Goodbye, Bram!`.  (Recall that `<Leader>` defaults to `\`.)
