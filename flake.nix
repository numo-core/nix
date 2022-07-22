{
  description = "A collection of opinionated technology for numo";

  outputs = { self }: {

    templates = {

      ci = {
        path = ./templates/ci;
        description =
          "A template for pre-commit checks that can also be used for CI";
      };

      devshell = {
        path = ./templates/devshell;
        description = "A template for a devshell";
      };

    };

    overlay = import ./overlay;

  };
}
