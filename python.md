# Python

One of the design goals of this tap in general is to not duplicate things that might reasonably be expected to be on the OS already.  So, notably the compilers.  In principle, this includes python.  However, this turns out to be quite difficult.

It is possible to simply not put any python dependency in a recipe.  Brew will build against the installed python and link files into its own `site-packages`.  Two workarounds are necessary:
1. Brew's shims will inhibit access to `/usr/include/python3.x`.  The formula `sys-python` will install symbolic links to this directory.
2. It is necessary to point `$PYTHON_PATH` at `$HOMEBREW_PREFIX/lib/python3.x/site-packages`

That second hack is necessary because python only really knows about two package repositories: its own and the one in `~/.local`.  There is no equivalent of perl's `local::lib`.  However, it is possible to use a virtual environment; essentially a mini-copy of the OS where `bin/python3` is a pointer back to the system python.  This allows packages to be installed, will also see the ones in the system python, and does not need `$PYTHON_PATH` to find them.  But, it relies on the file `pyvenv.cfg` at top level
```
home = /usr/bin
include-system-site-packages = true
version = 3.9.7
```
Brew will not link this file.  It can be forced, in which case it will not be unlinked.

Another PITA is that packages such as `six` and `pybind11`, which we do not want to be duplicating, install for "current" versions, where current is 3.8, 3.9 and 3.10.  If the OS has a different version (Debian old-stable has 3.7), then these don't work.  So, it makes sense in this case to use a brewed python.  However, to avoid confusion with the system python, formulae need an explicit dependency on `python3`.  So, it's not really possible to choose the python version system by system.

It's not a huge overhead in context; normally python is a big package, but not compared to some others:
```sh
.linuxbrew/Cellar% du -sk * | sort -n
...
77960	numpy
84364	onednn
96528	openfst@1.6.7
152056	cmake
307764	magma
319828	python@3.9
436304	nccl
615064	flashlight
829552	mkl
1044636	pytorch
1411308	arrayfire
3921080	cudnn@8.2
5148336	cuda@11.3
...
```
