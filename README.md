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

#### Test Area Detector IOC
* Install TS-EA-IOC-01
    ```bash
    $ nix-env -f https://github.com/hir12111/dlspkgs/tarball/master -iA TS-EA-IOC-01
    ```
* Run IOC
    ```bash
    $ TS-EA-IOC-01.sh
    ```
* Run gui (keep in mind you'll need to have arial and courier fonts installed in your system)
    ```bash
    $ TS-EA-IOC-01-gui
    ```

#### Test Malcolm Instance
* Install TS-ML-MALC-01
    ```bash
    $ nix-env -f https://github.com/hir12111/dlspkgs/tarball/master -iA TS-ML-MALC-01
    ```
* Run Malcolm instance
    ```bash
    $ TS-ML-MALC-01
    ```
