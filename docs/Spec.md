# Specs

## Loading hooks

<!-- markdownlint-disable MD013 -->
| Property         | Type | Description | `lazy.nvim` equivalent |
|------------------|------|-------------|-----------------------|
| **[1]** | `string` | REQUIRED. The plugin's name (not the module name, and not the url). This is the directory name of the plugin in the packpath and is usually the same as the repo name of the repo it was cloned from. | `name`[^1] |
| **enabled?** | `boolean` or `fun():boolean` | When `false`, or if the `function` returns `nil` or `false`, then this plugin will not be included in the spec. | `enabled` |
| **beforeAll?** | `fun(lze.Plugin)` | Always executed upon calling `require('lze').load(spec)` before any plugin specs from that call are triggered to be loaded. | `init` |
| **before?** | `fun(lze.Plugin)` | Executed before a plugin is loaded. | None |
| **after?** | `fun(lze.Plugin)` | Executed after a plugin is loaded. | `config` |
| **priority?** | `number` | Only useful for **start** plugins (not lazy-loaded) added within **the same `require('lze').load(spec)` call** to force loading certain plugins first. Default priority is `50`, or the value of `vim.g.lze.default_priority`. | `priority` |
| **load?** | `fun(string)` | Can be used to override the `vim.g.lze.load(name)` function for an individual plugin. (default is `vim.cmd.packadd(name)`)[^2] | None. |
| **allow_again?** | `boolean` or `fun():boolean` | When a plugin has ALREADY BEEN LOADED, true would allow you to add it again. No idea why you would want this outside of testing. | None. |
| **lazy?** | `boolean` | Using a handler's field sets this automatically, but you can set this manually as well. | `lazy` |
<!-- markdownlint-enable MD013 -->

## Lazy-loading triggers provided by the default handlers

<!-- markdownlint-disable MD013 -->
| Property | Type | Description | `lazy.nvim` equivalent |
|----------|------|-------------|----------------------|
| **event?** | `string` or `{event?:string\|string[], pattern?:string\|string[]}\` or `string[]` | Lazy-load on event. Events can be specified as `BufEnter` or with a pattern like `BufEnter *.lua`. | `event` |
| **cmd?** | `string` or `string[]` | Lazy-load on command. | `cmd` |
| **ft?** | `string` or `string[]` | Lazy-load on filetype. | `ft` |
| **keys?** | `string` or `string[]` or `lze.KeysSpec[]` | Lazy-load on key mapping. | `keys` |
| **colorscheme?** | `string` or `string[]` | Lazy-load on colorscheme. | None. `lazy.nvim` lazy-loads colorschemes automatically[^3]. |
| **dep_of?** | `string` or `string[]` | Lazy-load before another plugin but after its `before` hook. Accepts a plugin name or a list of plugin names. |  None but is sorta the reverse of the dependencies key of the `lazy.nvim` plugin spec |
| **on_plugin?** | `string` or `string[]` | Lazy-load after another plugin but before its `after` hook. Accepts a plugin name or a list of plugin names. | None. |
| **on_require?** | `string` or `string[]` | Accepts a top-level **lua module** name or a list of top-level **lua module** names. Will load when any submodule of those listed is `require`d | None. `lazy.nvim` does this automatically. |
<!-- markdownlint-enable MD013 -->

[^1]: In contrast to `lazy.nvim`'s `name` field, a `lze.PluginSpec`'s `name` *is not optional*.
      This is because `lze` is not a plugin manager and needs to be told which
      plugins to load.
[^2]: for example, lazy-loading cmp sources will
      require you to source its `after/plugin` file,
      as packadd does not do this automatically for you.
[^3]: The reason this library doesn't lazy-load colorschemes automatically is that
      it would have to know where the plugin is installed in order to determine
      which plugin to load.

## Source

- https://github.com/BirdeeHub/lze/blob/master/README.md
