Me trying to make impermance work with userborn.
Can be tested like this:

```
$ nix run github:Mic92/userborn-with-impermanence#nixosConfigurations.myhost.config.system.build.vmWithDisko
```

## Current issues

- [x] ~~`environment.persistence.<mountpoint>.users.<user>.directories` have the wrong user/group.~~, see https://github.com/nix-community/impermanence/pull/223

