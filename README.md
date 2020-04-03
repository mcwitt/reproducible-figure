# Example of reproducible TeX/TikZ figure using Nix

TikZ reproduction of the linked [sketch](./img/sketch.jpg).

The result looks like

![figure](./img/figure.png)

## Environment setup using Nix
Use [Nix][nix] to set up a reproducible environment for editing this
figure. Note that the first time these commands are run, there may be
a significant delay if the dependencies (e.g. TeXLive) need to be
downloaded and built.

[nix]: https://nixos.org/nix/

### Building from scratch
``` shell
nix-build
```
The output PDF is created in `./result`.

### Editing
``` shell
nix-shell
```
This drops you into a shell environment with the necessary dependencies.
E.g. you can then run
``` shell
pdflatex figure.tex
```
to rebuild the figure after editing the TeX code.

## Explanation of Nix files

- `default.nix` is the entry point for the `nix-build` and `nix-shell`
  commands. It imports the environment `nixpkgs` version and calls
  `package.nix`. Note: this method is not fully reproducible because
  the environment may define a different revision of `nixpkgs` than we
  used in the original build. For full reproducibility, use
  `release.nix` instead (this pins the version of `nixpkgs`).

- `package.nix` takes as input some `nixpkgs` repository and contains
  the actual build instructions. In this case, we can use the
  `texFunctions.runLaTeX` helper, so the only work to be done is to
  specify the additional packages we depend on.

- `release.nix` is the entry point for reproducible builds. That is,
  it serves the same purpose as `default.nix`, but pins the version of
  `nixpkgs` that is used to build the environment (the pinned version
  is specified in `nixpkgs.json`). This can be used with `nix-build`
  and `nix-shell` by passing it as an arugment, e.g. `nix-build
  release.nix`.

- `nixpkgs.json` specifies the revision of the `nixpkgs` repository
  used for the reproducible build. It is imported by `release.nix`
