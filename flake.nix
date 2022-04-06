{
  description = "A collection of opinionated technology for numo";

  outputs = { self }: {

    templates = {

      ci = {
        path = ./templates/ci;
        description = "A template for pre-commit checks that can also be used for CI";
      };

      devshell = {
        path = ./templates/devshell;
        description = "A template for a devshell";
      };

      devshell-no-flake = {
        path = ./templates/devshell-no-flake;
        description = "A template for a devshell that does not require flake support";
      };

    };

  };
}
