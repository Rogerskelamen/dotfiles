# dotfiles

My personal dotfiles, feel free to read and copy

The following content is my guidance for archlinux configuring. For convenience, I write here in Chinese.

# Screenshot

![desktop-screenshot-1](https://raw.githubusercontent.com/Rogerskelamen/dotfiles/master/static/images/desktop-screenshot-1.png)

![desktop-screenshot-2](https://raw.githubusercontent.com/Rogerskelamen/dotfiles/master/static/images/desktop-screenshot-2.png)

# Arch Linux 入坑指南

本篇指南针对仅仅使用windows manager环境不用desktop environment的指南，总所周知(bushi)，如果摒弃DE之后，很多系统基础软件和设置都不会存在，所以从WM开始配置确实堪称地狱难度。为此有必要写出本篇指南记录配置和入坑细节。

*本指南的前提是你已经安装好了Arch Linux，并且已经安装并启动了任意一种WM环境(比如dwm，i3等)*

## Recommended WM

- Xorg

    i3/dwm/awesome-wm

- Wayland

    sway/hyprland

    *Wayland对于intel显卡的电脑更为友好*

## NetWork(网络)

- iwd

如果你更倾向于使用命令行，可以使用iwd(Internet Wireless Daemon)，需要配合dhcpcd一起使用:

```bash
yay -S iwd dhcpcd
```

*经过[一些配置](https://wiki.archlinuxcn.org/wiki/Iwd#%E5%90%AF%E7%94%A8%E5%86%85%E7%BD%AE%E7%BD%91%E7%BB%9C%E9%85%8D%E7%BD%AE)，你也可以使用iwd内置的DHCP客户端*

- NetworkManager

如果你倾向于使用更为现代化和用户友好的软件，建议使用NetworkManager。它最初由红帽开发的网络管理工具，现由GNOME进行管理和维护，[这是](https://networkmanager.dev/)它的官网。

那么可以安装一下NetworkManager(**一定要确保自己系统中有一个可以上网的工具，并且自己能够用它来连上互联网!**):

```bash
yay -S networkmanager
```

*注意，NetworkManager已内置DHCP服务客户端*

使用自带的命令行工具`nmcli`进行网络的配置:

```bash
nmcli device wifi list  # 列出附近的Wi-Fi
nmcli device wifi connect SSID password 88888888  # 连接到一个Wi-Fi网络
nmcli device wifi show-password  # 显示当前连接Wi-Fi网络的密码
nmcli connection show  # 显示已记录连接的列表
nmcli connection up NAME  # 激活连接
nmcli radio wifi off/on   # 关闭/开启Wi-Fi
```

*更多详情请看[arch维基](https://wiki.archlinuxcn.org/zh-hans/NetworkManager)*

当然，我们可以安装一个系统托盘工具来管理networkmanager:

```bash
yay -S network-manager-applet
```

## Backlight(背光)

屏幕亮度的数据是存储在`/sys/class/backlight/intel_backlight`文件夹中的，所以如果需要调节亮度可修改文件夹下的`brightness`文件(需要root权限)，查看系统可支持的最大亮度可打印`max_brightness`的值

这里推荐一个命令行工具来管理背光：

- brightnessctl

```bash
brightnessctl s 5+   # 增加5亮度
brightnessctl s 5-   # 减少5亮度
```

## Dark mode(暗黑模式)

很多操作系统(*比如MacOS和移动端OS*)都支持在傍晚将系统的明亮主题切换为暗黑主题，如果想要在只有WM的Archlinux上实现这一特性，可以参考[官方文档](https://wiki.archlinux.org/title/Dark_mode_switching)。主要需要安装的软件包：

```bash
yay -S gnome-themes-extra adwaita-qt5-git adwaita-qt6-git # themes
yay -S darkman # themes control
```

这里主要安装的是gnome默认主题adwaita的dark版本，如果想要其他themes请自行下载安装

## 电量管理

使用命令行工具acpi:`acpi -b`

推荐使用托盘工具：

- cbatticon

## 显卡驱动

如果你是intel的显卡(一般用来装arch的老笔电基本上都是intel集成显卡)，那么来看[这里](https://zh.wikipedia.org/wiki/%E8%8B%B1%E7%89%B9%E7%88%BE%E9%A1%AF%E7%A4%BA%E6%A0%B8%E5%BF%83%E5%88%97%E8%A1%A8)对号入座，然后查看[此文](https://wiki.archlinuxcn.org/wiki/Intel_graphics#%E5%AE%89%E8%A3%85)进行安装配置

## 音量控制

首先安装`alsa`(Advanced Linux Sound Architecture):

```bash
yay -S alsa-utils
```

接着根据[此文](https://wiki.archlinuxcn.org/wiki/Advanced_Linux_Sound_Architecture#%E8%A7%A3%E9%99%A4%E5%90%84%E5%A3%B0%E9%81%93%E7%9A%84%E9%9D%99%E9%9F%B3)进行设置

通过amixer进行音量控制:

```bash
amixer set Master 5%+ # 升高音量
amixer set Master 5%- # 降低音量
amixer set Master 0%  # 静音
```

如果想要进行图形化管理操作的话，可以使用其他软件工具：

- pulseaudio

    声音服务器，是上述软件和声卡等硬件进行通信的桥梁

- pavucontrol

    管理声音的图形操作界面软件

- pasystray

    可以调用pavucontrol，用来管理声音的系统托盘软件

```bash
yay -S pulseaudio pavucontrol pasystray
```

## Music player(音乐播放器)

不建议安装netease-cloud-music(网易云)，而是安装像yesplaymusic这样对网易云的封装软件，因为前者是deepin和网易合作开发的，已经很多年没有维护了。

```bash
yay -S yesplaymusic
```

## Display manager

如果你只安装了WM环境并且只能输入`startx`来启动，那很可能你需要一个display manager，我这里安装的是lightdm：

```bash
yay -S lightdm lightdm-gtk-greeter
```

然后参考[此文](https://wiki.archlinuxcn.org/wiki/%E6%98%BE%E7%A4%BA%E7%AE%A1%E7%90%86%E5%99%A8#%E4%BC%9A%E8%AF%9D%E9%85%8D%E7%BD%AE)将你的wm配置到会话列表中，以便于lightdm读取并在登录页面显示。

*可能需要安装xorg-xinit*

## Screen Locker

你可能想要安装一个锁屏软件，这样你要是有事暂时离开你的电脑也不用担心有人擅自使用你的电脑了。这里如果已经安装了`lightdm`的话，建议使用`light-locker`相互配合：

```bash
yay -S light-locker
```

设置好开机autostart之后，就可以使用`light-locker-command -l`来锁定屏幕了

## Composite Manager(合成器)

在Xorg下，你可能需要额外安装一个合成器来对WM产生特定的渲染效果(如果是Wayland话，一般混成器就已经集成了特殊渲染效果，比如Hyprland)

这里推荐使用[picom](https://wiki.archlinux.org/title/Picom)，我这里直接推荐使用picom-jonaburg-git(jonaburg对picom的fork，提供了很多开箱即用的渲染特性):

```bash
yay -S picom-jonaburg-git
```

## 中文输入法

> 中文输入法本身有两种框架，ibus和fcitx，我在这里使用的是[fcitx5](https://fcitx-im.org/wiki/Fcitx_5/zh-cn)。

安装完成之后还需要集成到系统中去，需要在`/etc/environment`文件中添加如下几行：

```
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
GLFW_IM_MODULE=ibus
```

*PS: fcitx可以按Ctrl+;来显示剪切板*

在fcitx5上的中文输入法引擎，[有很多种](https://fcitx-im.org/wiki/Input_method_engines#Chinese)，我选择的是[rime](https://rime.im/)，其有良好的扩展性和可移植性。

*PS: 刚开始rime的默认输入法是繁体的，需要按Ctrl+~来切换为简体*

如果需要配置rime的话，需要在`~/.local/share/fcitx5/rime/default.custom.yaml`中设置，比如你想要设置出词的页数就在文件中写入：

```yaml
patch:
  "menu/page_size": 7
```

<u>这里强烈推荐一下一款fcitx5的皮肤：[fcitx5-nord](https://github.com/tonyfettes/fcitx5-nord)</u>

## Fonts(字体)

- firacode-nerd

    用于编程的字体，基于firacode的nerdfont补丁字体包，可支持ligature

- ibmplex-mono-nerd

    对firacode斜体字的补充，不支持ligature

- noto-fonts

    谷歌推出的非常标准耐看的字体，我基本将其作为文本显示的主力字体，当然需要中文的话要同时下载noto-fonts-cjk

- adobe-source-fonts

    adobe公司推出的标准字体，我主要用来填补noto-fonts-cjk的中文显示，它包含了多种中文字体类别如sans、serif等，甚至包括香港(hk)和台湾(tw)的特殊字体

- wqy-microhei

    文泉驿微米黑，质量很高的中文字体。作为我中文显示的主要字体，不用再去特意下载wqy-zenhei

- noto-fonts-emoji

    提供emoji图标支持，同为谷歌的noto系列，基本上可以满足大部分emoji图标需求(本人的dwm状态栏图标也是用的noto-fonts-emoji)

## File manager(文件系统管理器)

我一直使用的是ranger这个cli的file manager，所以在此记录ranger的使用指南。

如果使用了我的dotfiles，就需要安装对应的软件来确保ranger能够正确预览文件：

```bash
yay -S ffmpegthumbnailer epub-thumbnailer-git fontforge
```

除此之外，为了使用kitty下的图片预览功能，还需要安装imagemagick:

```bash
yay -S imagemagick
```

最好还是使用ueberzug(虽然原作者已经停止维护该项目)，因为ranger对它的支持是最好的。

```bash
yay -S ueberzug
```

为了ranger更好的用户体验，我还安装了以下插件:

- [ranger-devicons2](https://github.com/cdump/ranger-devicons2)

    用glyphs图标的形式显示文件的类型

如果必须要一个图形界面的文件系统管理器，推荐安装nautilus:

```bash
yay -S nautilus
```

## Dictionary(字典)

可以使用命令行翻译软件[translate-shell](https://github.com/soimort/translate-shell)：

```bash
yay -S translate-shell
```

## Editor(文本编辑器)

当然是用伟大的Vim编辑器啦！(*当然我自己用的是NeoVim*)

```bash
yay -S neovim
```

但有时候我们在编辑binary(二进制)文件的时候，想用到`xxd`指令转码。这时候就发现`xxd`是vim内置的程序，单独安装neovim是没有的，那我们就得额外安装一下`xxd`：

```bash
yay -S xxd-standalone
```

## PDF/EPUB Viewer(阅读器)

PDF阅读器我暂时使用的是evince，因为它拥有vim模式的移动方式，统一了我的工作环境：

```bash
yay -S evince
```

在尝试了很久的EPUB阅读器之后(包括[ebook-viewer](https://github.com/michaldaniel/ebook-viewer))，我发现了[foliate](https://johnfactotum.github.io/foliate/)，并认定它为唯一真神：

```bash
yay -S foliate
```

*Note: 需要注意的是，ranger本身不适配foliate，所以需要手动添加(直接拷贝我的dotfiles就好了)*
