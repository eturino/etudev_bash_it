etudev_bash_it Cookbook
=======================
this cookbook installs eturino's fork of revans' project "bash-it" for the given users

see https://github.com/eturino/bash-it
and https://github.com/revans/bash-it

Requirements
------------

#### packages
- `sudo` - etudev_bash_it needs git to execute the clone and install for other users
- `git` - etudev_bash_it needs git to get the bash-it code

#### cookbooks
- `git` - etudev_bash_it needs git to get the bash-it code, and will depend on the git cookbook

Attributes
----------

#### etudev_bash_it::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['etudev_bash_it']['repository']</tt></td>
    <td>String</td>
    <td>location of the bash-it repository</td>
    <td><tt>https://github.com/eturino/bash-it</tt></td>
  </tr>
  <tr>
    <td><tt>['etudev_bash_it']['users']</tt></td>
    <td>Array</td>
    <td>array of user names (need to exist)</td>
    <td><tt>[]</tt></td>
  </tr>
</table>

Usage
-----
#### etudev_bash_it::default

Just include `etudev_bash_it` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[etudev_bash_it]"
  ]
}
```

and specify in the attributes the users list (see attributes)

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Eduardo Turiño, eturino, https://github.com/eturino
