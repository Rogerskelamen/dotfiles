# dotfiles

My personal dotfiles, feel free to read and copy

The following contents are my guidance for archlinux configuring. For convenience, I write here in Chinese.

# Arch Linux 入坑指南

本篇指南针对仅仅使用windows manager环境不用desktop environment的指南，总所周知(bushi)，如果摒弃DE之后，很多基本的配置都会消失，所以从WM开始配置确实堪称地狱难度。为此有必要写出本篇指南记录配置和入坑细节。

*本指南的前提是你已经安装好了Arch Linux，并且已经安装并启动了任意一种WM环境(比如dwm，i3等)*

## backlight(背光)

屏幕亮度的数据是存储在`/sys/class/backlight/intel_backlight`文件夹中的，所以如果需要调节亮度可修改文件夹下的`brightness`文件(需要root权限)，查看系统可支持的最大亮度可打印`max_brightness`的值

这里推荐一个命令行工具来管理背光：

- brightnessctl

## 电量管理

使用命令行工具acpi:`acpi -b`

推荐使用托盘工具：

- cbatticon

## 显卡驱动

如果你是intel的显卡(一般用来装arch的老笔电基本上都是intel集成显卡)，那么来看[这里](https://zh.wikipedia.org/wiki/%E8%8B%B1%E7%89%B9%E7%88%BE%E9%A1%AF%E7%A4%BA%E6%A0%B8%E5%BF%83%E5%88%97%E8%A1%A8)对号入座，然后查看[此文](https://wiki.archlinuxcn.org/wiki/Intel_graphics#%E5%AE%89%E8%A3%85)进行安装配置

## 音量控制

首先安装`alsa`:

```zsh
yay -S alsa-utils
```

接着根据[此文](https://wiki.archlinuxcn.org/wiki/Advanced_Linux_Sound_Architecture#%E8%A7%A3%E9%99%A4%E5%90%84%E5%A3%B0%E9%81%93%E7%9A%84%E9%9D%99%E9%9F%B3)进行设置

如果想要进行管理的话，可以使用工具：

- pulseaudio

    声音服务器，是上次软件和声卡等硬件进行通信的桥梁

- pavucontrol

    管理声音的图形操作界面软件

- pasystray

    可以调用pavucontrol，用来管理声音的系统托盘软件

```zsh
yay -S pulseaudio pavucontrol pasystray
```

## display manager

如果你只安装了WM环境并且只能输入`startx`来启动，那很可能你需要一个display manager，我这里安装的是lightdm：

```zsh
yay -S lightdm lightdm-gtk-greeter
```

然后参考[此文](https://wiki.archlinuxcn.org/wiki/%E6%98%BE%E7%A4%BA%E7%AE%A1%E7%90%86%E5%99%A8#%E4%BC%9A%E8%AF%9D%E9%85%8D%E7%BD%AE)将你的wm配置到会话列表中，以便于lightdm读取并在登录页面显示。

*可能需要安装xorg-xinit*

## 中文输入法

> 中文输入法本身有两种框架，ibus和fcitx，我在这里使用的是[fcitx5](https://fcitx-im.org/wiki/Fcitx_5/zh-cn)。

*PS: fcitx可以按Ctrl+;来显示剪切板*

在fcitx5上的中文输入法引擎，[有很多种](https://fcitx-im.org/wiki/Input_method_engines#Chinese)，我选择的是[rime](https://rime.im/)，其有良好的扩展性和可移植性。

*PS: 刚开始rime的默认输入法是繁体的，需要按Ctrl+~来切换为简体*

## 字体

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

## 文件系统管理器

我一直使用的是ranger这个cli的file manager，所以在此记录ranger的使用指南。

如果使用了我的dotfiles，就需要安装对应的软件来确保ranger能够正确预览文件：

```zsh
yay -S ffmpegthumbnailer epub-thumbnailer-git fontforge
```
