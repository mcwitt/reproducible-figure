{ pkgs }:
pkgs.texFunctions.runLaTeX {
  rootFile = ./figure.tex;
  texPackages = { inherit (pkgs.texlive) pgf preview xcolor; };
}
