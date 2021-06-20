{ poetry2nix, projectDir, buildPython }:

poetry2nix.mkPoetryApplication {
  projectDir = projectDir;
  python = buildPython;
  overrides = poetry2nix.overrides;
}
