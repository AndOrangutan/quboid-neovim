# Plugin Spec

<!-- markdownlint-disable MD013 -->
| Property         | Type | Description | `lazy.nvim` equivalent |
|------------------|------|-------------|-----------------------|
| **[1]** | `string` | The plugin's name (not the module name). This is what is passed to the `load(name)` function. | `name`[^1] |
| **enabled** | `boolean?` or `fun():boolean` | When `false`, or if the `function` returns false, then this plugin will not be included in the spec. | `enabled` |
| **beforeAll** | `fun(lz.n.Plugin)?` | Always executed before any plugins are loaded. | `init` |
| **before** | `fun(lz.n.Plugin)?` | Executed before a plugin is loaded. | None |
| **after** | `fun(lz.n.Plugin)?` | Executed after a plugin is loaded. | `config` |
| **event** | `string?` or `{event?:string\|string[], pattern?:string\|string[]}\` or `string[]` | Lazy-load on event. Events can be specified as `BufEnter` or with a pattern like `BufEnter *.lua`. | `event` |
| **cmd** | `string?` or `string[]` | Lazy-load on command. | `cmd` |
| **ft** | `string?` or `string[]` | Lazy-load on filetype. | `ft` |
| **keys** | `string?` or `string[]` or `lz.n.KeysSpec[]` | Lazy-load on key mapping. | `keys` |
 **colorscheme** | `string?` or `string[]` | Lazy-load on colorscheme. | None. `lazy.nvim` lazy-loads colorschemes automatically[^2]. |
| **lazy** | `boolean?` | Lazy-load manually, e.g. using `trigger_load`. Will disable lazy-loading if explicitly set to `false`. | `lazy` |
| **priority** | `number?` | Only useful for **start** plugins (not lazy-loaded) to force loading certain plugins first. Default priority is `50`. | `priority` |
| **load** | `fun(string)?` | Can be used to override the `vim.g.lz_n.load()` function for an individual plugin. | None. |
<!-- markdownlint-enable MD013 -->
