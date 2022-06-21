## Nvim

The directory structure for the nvim configuration is shown below where the lua folder contains all the configuration for LSP and the plugin. Currently, the configuration only support Neovim 0.8+. I am using [packer.nvim](https://github.com/wbthomason/packer.nvim) for my plugin/package manager

```
nvim
├── autoload
├── init.lua
└── lua
```

Steps:
* Install the package manager ([packer.nvim](https://github.com/wbthomason/packer.nvim))
* Download the code (nvim) and `cd` to the nvim
* Run PackerSync to download all the plugin and compile
