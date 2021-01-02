# Phil Garner's homebrew-tap

A generic homebrew tap to publish builds for my software and more generally for Idiap speech tools.  Current feeling is that many things in [BuSLR](https://github.com/idiap/buslr) can be ported here.

One key thing we need to support is the binary compute libraries, namely MKL and CUDA.

As of 2020 going into 2021, the Intel installer is difficult.  There seems to be no way to stop it installing both `ia32` and `intel64` architectures, and the conda packages too (why?).  Further, the MacOS package is actually just a graphical installer, so doesn't really make sense as a cask either.  However, given that Intel does support conda, the trick here is to just go get the conda packages.  It's basically what I did in [BuSLR](https://github.com/idiap/buslr) but now more confident it's a good solution.

By contrast, NVidia doesn't ship headers in its conda packages, but the binary distribution works.
