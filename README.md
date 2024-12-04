# DLSPKGS

Nix derivations for DLS branch of EPICS support modules

## Getting started
### Prerequisites
* Install nix
    ```bash
    $ curl -L https://nixos.org/nix/install | sh
    ```
* Add latest nixpkgs channel
    ```bash
    $ nix-channel --add https://nixos.org/channels/nixpkgs-unstable
    ```

### Examples of installing a package
#### EPICS base
* Install EPICS base
    ```bash
    $ nix-env -f https://github.com/hir12111/dlspkgs/tarball/master -iA dls-epics-base
    ```
* Confirm that you can now use caget, caput and camonitor
