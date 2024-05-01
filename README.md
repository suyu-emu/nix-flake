# Suyu nix flake.
This is a flake to allow for the installation of suyu on systems using the Nix package manager.

## Usage

Firstly, ensure git is installed in your ***system*** packages, since this is not hosted on github, gitlab, etc... It will ***not*** work with git installed in your user packages.

```nix
environment.systemPackages = with pkgs; [
    # the rest of your packages here
    git
    # more of your packages here
];
```

Add the following in your flake inputs:

```nix
{
    inputs = {
        # the rest of your inputs here

        suyu.url = "git+https://git.suyu.dev/suyu/nix-flake";
        suyu.inputs.nixpkgs.follows = "nixpkgs"; # optional, saves space, recommended

        # more of your inputs
    };
}
```

Afterwards, you can add it to your user or system or user packages by referring to `suyu.packages.YOURPLATFORM.suyu` or `suyu.packages.YOURPLATFORM.default` in your flake outputs.

**Note:** This will compile the package from scratch. It can take anywhere between 5-30 minutes depending on your system. 

---

Currently supported platforms:
- [x] x86_64-linux
- [ ] aarch64-linux
- [ ] x86_64-darwin
- [ ] aarch64-darwin

Feel free to submit a PR after you have tested it works on other platforms. I do not own any of the other devices and I cannot guarantee it will work on those.

