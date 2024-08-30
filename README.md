## How to install the Awesome version?
      git clone git@github.com:Nemausa/neovim-config.git ~/.config/nvim && nvim

#### Debug in Windows
[llvm download-17.0.1](https://github.com/llvm/llvm-project/releases/download/llvmorg-17.0.1/LLVM-17.0.1-win64.exe)
[ninja](https://github.com/ninja-build/ninja/releases)
[gcc](https://winlibs.com/)

#### Markdown
```
Windows
cd ~/AppData/Local/nvim-data/lazy/markdown-preview.nvim
Ubuntu
cd ~/.local/share/nvim/site/pack/lazy/start/markdown-preview.nvim
npm install
```

#### LSP
- **ctags**: ctags -R --languages=C++ --c++-kinds=+px --fields=+iaS --extra=+q .

#### snip
pip3 install pynvim
CocInstall coc-pyright
CocInstall coc-snippets
