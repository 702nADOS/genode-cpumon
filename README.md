# genode-cpumon
Genode CPU monitoring server.

### Building
The custom Makefile builds the entire Fiasco.OC and Genode system including its toolchain and external dependencies into a `build/` and `contrib/` directory respectively. To manually execute steps within the build process see the Makefile or the Genode documentation:
http://genode.org/documentation/developer-resources/getting_started

The toolchain installs executables to `/usr/local/genode-gcc` as part of the `tool_chain` script. Everything else stays within the repository.

Inter-target dependencies are not resolved automatically (yet).

### Required packages
The following packages are required for building the Genode toolchain:

`sudo apt-get install libncurses5-dev texinfo autogen autoconf2.64 g++ libexpat1-dev flex bison gperf`

For building Genode:

`sudo apt-get install make pkg-config gawk subversion expect git`

For running Genode in QEMU:

`sudo apt-get install libxml2-utils syslinux qemu`

For some additional ports you may need:

`sudo apt-get install xsltproc yasm iasl lynx`

### Folder structure
Custom repos:

| Folder          | Description                             |
| --------------- | --------------------------------------- |
| `repos/cpumon/` | CPU monitoring server                   |

The provided Makefile creates the following directories:

| Folder                      | Description               |
| --------------------------- | ------------------------- |
| `build/`                    | all build files           |
| `build/toolchain-TARGET/`   | Genode toolchain          |
| `build/genode-TARGET/`      | Genode build dir          |
| `contrib/`                  | external Genode libraries |

### VDE
The VDE network can be set up using `make vde`. VDE functionality requires a manual build of QEMU with VDE support enabled. Reset the VDE network using `make vde-stop`.

### Fine-grained CPU time
The Fiasco.OC kernel by default only returns timing information at a resolution of 1ms. Granularity can be increased by changing line 51 of `build/genode-TARGET/kernel/fiasco.oc/globalconfig.out` to

`CONFIG_FINE_GRAINED_CPUTIME=y`
