{ lib, fetchFromGitHub, python39, python39Packages }:

let
  python = let
    packageOverrides = self: super: {
      marshmallow = super.marshmallow.overridePythonAttrs (old: rec {
        version = "3.14.1";
        src = super.fetchPypi {
          pname = "marshmallow";
          inherit version;
          sha256 = "sha256-TAXBaE4Ol/53nGK5GHjxc7k3/gl7NWzYL3k0ZPW8YTg=";
        };
      });
      placebo = with python.pkgs;
        buildPythonPackage rec {
          pname = "placebo";
          version = "0.9.0";

          src = fetchPypi {
            inherit pname version;
            sha256 =
              "03157f8527bbc2965b71b88f4a139ef8038618b346787f20d63e3c5da541b047";
          };

          checkInputs = [ boto3 ];
        };
      dlint = with python.pkgs;
        buildPythonPackage rec {
          pname = "dlint";
          version = "0.11.0";
          format = "wheel";
          src = fetchPypi {
            inherit pname version format;
            sha256 =
              "e7297325f57e6b5318d88fba2497f9fea6830458cd5aecb36150856db010f409";
          };

          propagatedBuildInputs = [ flake8 ];
        };
      unix-ar = with python.pkgs;
        buildPythonPackage rec {
          pname = "unix_ar";
          version = "0.2.1";
          src = fetchPypi {
            inherit pname version;
            sha256 =
              "bf9328ec70fa3a82f94dc26dc125264dbf62a2d8ffb1a3c8c8a8230175e72c4e";
          };

          doCheck = false;
          checkInputs = [ ];
          nativeBuildInputs = [ ];
          propagatedBuildInputs = [ ];
        };
    };

  in python39.override {
    inherit packageOverrides;
    self = python;
  };
in with python.pkgs;
python39Packages.buildPythonApplication rec {

  pname = "aws-gate";
  version = "0.11.2";

  src = fetchFromGitHub {
    owner = "xen0l";
    repo = "aws-gate";
    rev = "0.11.2";
    sha256 = "sha256-EqTvwTq/UTDRju/UIQ7Jjz2gp5H+k5esWmD93keIspw=";
  };
  postPatch = ''
    substituteInPlace requirements/requirements.txt --replace "cryptography==36.0.1" "cryptography>=36.0.0"
    substituteInPlace requirements/requirements.txt --replace "requests==2.26.0" "requests>=2.25.1"
    substituteInPlace requirements/requirements.txt --replace "boto3~=1.17.7" "boto3>=1.17.7"
  '';
  checkInputs = [
    attrs
    bandit
    black
    flake8
    hypothesis
    invoke
    pre-commit
    pylint
    pytest
    pytest-cov
    pytest-black
    pytest-datadir
    pytest-mock
    pytest-pylint
    pytest-flake8
    placebo
    dlint
  ];
  installCheckPhase = "./tests/run.py";
  doCheck = false;
  buildInputs = [ packaging ];
  propagatedBuildInputs =
    [ cryptography pyyaml wrapt requests marshmallow unix-ar boto3 ];
  meta = with lib; {
    maintainers = with maintainers; [ flurie ];
    description = "AWS SSM Session Manager client CLI";
  };
}
