{
  description = "Go development environment";

  inputs = {
    nixpkgs.url = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      system = "x86_64-linux";
    in
    {
      devShells."${system}".default =
        let
          pkgs = import nixpkgs { inherit system; };
        in
        pkgs.mkShell {
          name = "go-dev-shell";

          packages = with pkgs; [
            go
            gopls
            go-tools
            gotools
            delve
          ];

          # TODO: move this to a shell script
          shellHook = ''
            echo "Go version: $(go version)"
            echo "GOPATH: $(go env GOPATH)"
            echo "GOBIN: $(go env GOBIN)"
          '';
        };
    };
}
