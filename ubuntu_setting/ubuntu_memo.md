# UBUNTU setup
## 
### ディレクトリ名を英語にする
``` 
LANG=C xdg-user-dirs-update --force
rm -rf デスクトップ ダウンロード テンプレート 公開 ドキュメント ミュージック ピクチャ ビデオ
```

```
sudo apt install -y mozc-utils-gui
```

```
sudo vi /etc/default/keyboard
```

```
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="pc105"
XKBLAYOUT="jp"
XKBVARIANT=""
XKBOPTIONS="ctrl:nocaps"

BACKSPACE="guess"
```

```
sudo systemctl restart console-setup
```

```
sudo apt install build-essential curl file git -y
sudo apt install zsh -y
chsh -s $(which zsh)
```

```
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true
gsettings set org.gnome.shell.extensions.ding show-home false
```
```

## neovim

```
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim -y
sudo apt install python3-neovim -y
```

```
git config --global user.name monjara
git config --global user.email yaginumee@gmail.com
git config --global core.editor nvim
```

```
sudo apt install xsel -y
sudo apt install tmux -y
sudo apt install tig -y
sudo apt install fzf -y
```

ripgrep
```
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb
```

7as1tsar
