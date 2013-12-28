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

# Practical usage example

## Preamble

The point of Glaive is to make it easy to configure maktaba plugins in
a non-maktaba-based plugin manager.  Unfortunately, there is a little extra
setup work required.

To see why, we must first understand the phases of loading a maktaba plugin.

1. Add the plugin to the `rtp`.  (This enables vim to find the files in the
   plugin's directories: `autoload/`, `plugin/`', etc.)
2. Install the plugin. (This creates the plugin object, which enables it to be
   configured.)
3. Configure the plugin.  (This is where Glaive comes in.)
4. Load the plugin.

Traditional plugin managers (such as [Vundle](https://github.com/gmarik/vundle)
or [NeoBundle](https://github.com/Shougo/neobundle.vim)) only do step 1 for each
plugin.  Thus, we need to do step 2 _for each maktaba plugin, including Glaive
itself,_ before we can use Glaive.

Glaive comes with a convenient function, `glaive#Install()`, to do this.  Other
maktaba plugins may do the same; for instance,
[vtd](https://github.com/chiphogg/vim-vtd) has a `vtd#Install()` function.  If
not, one has to call `maktaba#plugin#Install('/full/path/to/myplugin')`.

## Usage example

This example uses [Vundle](https://github.com/gmarik/vundle), whose
plugin-adding command is `Bundle`.

The example maktaba plugin is [vtd](https://github.com/chiphogg/vim-vtd).  Our
goal is to use Glaive to enable mappings, and exclude tasks from the "work"
context by default.

```vim
" Step 1: load necessary plugins onto the rtp.
Bundle 'google/maktaba'
Bundle 'google/glaive'
Bundle 'chiphogg/vim-vtd'

" Step 2: Install the plugins.
call glaive#Install()
call vtd#Install()

" Step 3: Configure the plugins.
Glaive vim_vtd plugin[mappings] contexts=`['-work']`
```
