# Phil Garner's homebrew tap

## Overview

A generic homebrew tap to publish builds for my software and more generally for Idiap speech tools.  Supercedes [BuSLR](https://github.com/idiap/buslr), which worked but was never really future-proof.

## Compute

One key thing we need to support is the binary compute libraries, namely MKL and CUDA.

As of 2020 going into 2021, the Intel installer is difficult.  There seems to be no way to stop it installing both `ia32` and `intel64` architectures, and the conda packages too (why?).  Further, the MacOS package is actually just a graphical installer, so doesn't really make sense as a cask either.  However, given that Intel does support conda, the trick here is to just go get the conda packages.

By contrast, NVidia doesn't ship headers in its conda packages, but the binary distribution works.  The installation is quite big: 3G download, 5G unpack and 5G installation.  Consider using
```sh
HOMEBREW_TEMP=~/scratch/tmp brew install cuda
```
where `scratch` is larger than `/tmp`.

## Versions

This section is clearly evolving with time, however, as of late 2021...

The compute libraries are somewhat conservative regarding versions of dependencies.  CUDA 11 supports gcc 10 but not 11.  gcc 10.3 is [supported](https://gcc.gnu.org/) but [broken](https://gcc.gnu.org/bugzilla/show_bug.cgi?id=100102), so [Arch](https://archlinux.org/packages/community/x86_64/gcc10/) is difficult (try gcc 9).  Debian [stable has gcc 10.2](https://packages.debian.org/stable/devel/gcc).

In turn, [pytorch supports CUDA](https://pytorch.org/get-started/locally/) up to 11.3, so we don't try to install the later versions.

## Tips

This [example](https://github.com/syhw/homebrew/blob/master/Library/Contributions/example-formula.rb) is very useful.

