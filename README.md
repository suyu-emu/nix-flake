# Suyu nix flake
This is a flake to allow for the installation of suyu on systems using the Nix package manager.

## Usage

Firstly, ensure git is installed ***system-wide***, not just your user packages, since this is not hosted on github, gitlab, etc... It will ***not*** work with git installed in your user packages. If you are on NixOS, you must first add git to your system packages, rebuild and switch.

```nix
environment.systemPackages = with pkgs; [
    # the rest of your packages here
    git
    # more of your packages here
];
```

Any other Linux distro or MacOS install git via its package manager.

Then you can add the following in your flake inputs:

```nix
{
    inputs = {
        # the rest of your inputs here

        suyu.url = "git+https://git.suyu.dev/suyu/nix-flake";
        suyu.inputs.nixpkgs.follows = "nixpkgs"; # optional, saves space, recommended
        # suyu.inputs.systems.follows = "systems" # if you also have the systems flake installed,
        # if you do not know what that is, you can safely ignore

        # more of your inputs
    };
}
```

Afterwards, you can add it to your user or system or user packages by referring to `suyu.packages.YOURPLATFORM.suyu` or `suyu.packages.YOURPLATFORM.default` in your flake outputs.

**Note:** This will compile the package from scratch. It can take anywhere between 3-10 minutes depending on your system.

---

Currently supported platforms:
- [x] x86_64-linux
- [x] aarch64-linux (untested)
- [ ] ~~x86_64-darwin~~ (suyu not ready for regular MacOS use)
- [ ] ~~aarch64-darwin~~

Feel free to submit a PR after you have tested it works on untested platforms or unsupported ones. I do not own any of the other devices and I cannot guarantee it will work on those.

