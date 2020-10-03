# Changelog

## 0.2.3

* Bumped dependencies

## 0.2.2

* Missing SwiftPM product

## 0.2.1

* Rely on [jakeheis/SwiftCLI](https://github.com/jakeheis/SwiftCLI) in order to pass interrupts correctly

## 0.2.0

* **[Breaking]** Arguments will not be appended anymore, but instead passed as Bash argument

### Migration

In order to get the pre-`0.2.0` behavior, your need to append `$@` to your bash script.

```bash
# previous
$ echo Hello # implicitly passed World on $ archery greet World
# now
$ echo Hello $@ # $ archery greet World
Hello World
$ echo Hello $@ # $ archery greet
Hello
```

## 0.1.0

* Initial Release
