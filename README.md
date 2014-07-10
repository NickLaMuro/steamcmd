steamcmd Cookbook
=================
Installs and configures steam apps with [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD).

Attributes
----------

#### steamcmd::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['steamcmd']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### steamcmd::default

Just include `steamcmd` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[steamcmd]"
  ]
}
```

#### Convenience recipes

Just include app-specific recipe in your node's `run_list` or do `include_recipe` from inside your cookbook:

```
include_recipe 'steamcmd::counterstrike_source'
```

Avaialble recipes:

* counterstrike_source
* team_fortress
* day_of_defeat_source

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

Authors
------------

- [Marcin Sawicki](https://github.com/odcinek)
