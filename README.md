# nix

A set of configurations, libraries, and useful tooling for numo.

# contents

## templates

- CI: a flake that leverages the python pre-commit framework for code checking. See <https://github.com/numo-core/engsvc/blob/0d9d1e434db886ae34df837fc0d556ab4369fb65/.github/workflows/ci.yaml> for an example of how to use this for CI.

# prerequisites

In order to use flakes, one must be running nix 2.4, otherwise known as nixUnstable.

To install nixUnstable on a machine without nix-darwin or home-manager, do the following:

```sh
nix-env -iA nixUnstable && echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf
```

# usage

To pull a template, run the following:

```sh
nix flake init -t "git+ssh://git@github.com/numo-core/nix?ref=main#templates.ci"
```

The `git+ssh` protocol is necessary to ensure nix uses your git credentials for accessing private repos.
