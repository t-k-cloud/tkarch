gschema
========
What is gschema? It is the "source of truth" to generate initial user `dconf` database.

At the desktop environment, when user issues:
```sh
dconf write /path/to/key "value"
```
or change any value using `dconf-editor`, the change will be applied to `~/.config/dconf/user`.
And if you restart the corresponding GUI window, the changes will be reflected.

But what if we want to set dconf database before an user is even created? The answer is to change gschema!

Go to `/usr/share/glib-2.0/schemas`, you will find a lot of "factory settings".
Meanwhile, one can create *vendor override* files under the same directory, but it
must be named `*.gschema.override`. [1]

Once you have your `*.gschema.override` file like [this one](./10_tkarch.gschema.override),
just move it to `/usr/share/glib-2.0/schemas` and compile it to `gschemas.compiled` by
```sh
glib-compile-schemas /usr/share/glib-2.0/schemas/
```

Both gsettings and dconf (which is actually the backend for gsettings) look for the default settings in `/usr/share/glib-2.0/schemas/gschemas.compiled` when a user configuration is not found. [2]

Create `*.gschema.override`
=============================
To create your override file, use `dconf-editor` to change a value,
and then refer to the `dconf dump` results to figure out the value-setting format:
```sh
$ dconf dump /org/cinnamon/settings-daemon/peripherals/touchpad/
scroll-method='two-finger-scrolling'
horiz-scroll-enabled=true
three-finger-click=2
two-finger-click=3
```

And the key of your interested value needs to be found in the "source of truth":
```sh
$ cat org.cinnamon.settings-daemon.peripherals.gschema.xml | grep ...
id="org.cinnamon.settings-daemon.peripherals.touchpad"
```
 
Reference
=========
[1] https://man.archlinux.org/man/core/glib2/glib-compile-schemas.1.en

[2] https://unix.stackexchange.com/questions/687514
