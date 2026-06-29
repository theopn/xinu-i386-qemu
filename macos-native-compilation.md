# Natively Compiling Xinu on macOS

If you would like to natively compile Xinu instead of using the provided Docker image, refer to this document.

Testing environment:

> - M1 Macbook Air
> - macOS Tahoe 26.5.1

## Dependencies

You need x86/i686 build tools for the main Xinu compilation.
These dependencies are available via the [Homebrew](https://brew.sh/) package manager.

- [i686-elf-gcc](https://formulae.brew.sh/formula/i686-elf-gcc#default)
- [i686-elf-binutils](https://formulae.brew.sh/formula/x86_64-elf-binutils#default)
- [gawk](https://formulae.brew.sh/formula/gawk#default)
- [flex](https://formulae.brew.sh/formula/flex#default) and [bison](https://formulae.brew.sh/formula/bison#default)

## Modifications

1. Open `config/Makefile` and add `LFLAGS = -L$(shell brew --prefix flex)/lib` at the top where variables are defined.
    ```Makefile
    ...
    # Make the Xinu configuration program
    #

    LFLAGS = -L$(shell brew --prefix flex)/lib

    CC	= gcc
    LEX	= flex
    ...
    ```
2. Run the following `export` command to override the macOS default `flex` and `bison`.
    ```sh
    export PATH="$(brew --prefix bison)/bin:$(brew --prefix flex)/bin:$PATH"
    ```
3. Navigate to `compile/` and run:
    ```sh
    make clean && make COMPILER_ROOT=i686-elf-
    ```

If any of the steps fail, run `make clean` in the `compile` directory and repeat the steps.

## Boot

Once you have successfully compiled `xinu.elf`, use the QEMU command in the [README](../README.md) to boot Xinu.
QEMU is also [available in Homebrew](https://formulae.brew.sh/formula/qemu#default), so you can install it locally.


## Optional: Using macOS Native flex and bison

macOS ships with a *very* old - and I mean very old - version of `flex` and `bison`, and it is recommended to install the Homebrew versions.

> In macOS 26.5.1, the out-of-the-box `flex` and `bison` are:
> - `flex 2.6.4 Apple(flex-35)`  (released 2017)
> - `bison (GNU Bison) 2.3`      (released 2006)

However, it is possible to use them to compile Xinu by compiling the config file separately before the main compilation:

1. Navigate to `config/` and perform the following changes:
    a. Open `.yyleng` and change `extern int yyleng;` to `extern size_t yyleng;`.
    b. `config.l` and add `%option noyywrap` to the top of the file.
    c. Open the following commands:
        ```sh
        flex -o lex.yy.c config.l
        bison -y config.y
        gcc -o config y.tab.c
        ```
2. Navigate to `compile/` and run `make COMPILER_ROOT=i686-elf-`


## Disclaimer

The maintainer of this repository is not affiliated with Homebrew, and the packages mentioned in this document could become unavailable in the future, though this is unlikely.

