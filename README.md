# my-vimrc
我的Vim和Neovim配置  
My Vim &amp; Neovim config

---

* [环境需求](#环境需求)
* [主要功能](#主要功能)
* [配置我的Vim](#配置我的vim)
* [配置我的Neovim](#配置我的neovim)
	* [安装Neovim](#安装neovim)
	* [配置Neovim](#配置neovim)
* [主要快捷键](#主要快捷键)
	* [描述约定](#描述约定)
	* [键位与功能](#%EF%B8%8F键位与功能)
* [辅助快捷键](#辅助快捷键)
	* [描述约定](#描述约定)
	* [键位与功能](#%EF%B8%8F键位与功能)
* [【Neovim】代码补全、内容跳转等](#neovim代码补全内容跳转等)
	* [LSP 语言服务器协议](#lsp-语言服务器协议)
	* [安装本地LSP服务器并配置Neovim LSP客户端](#🆅-安装本地lsp服务器并配置neovim-lsp客户端)
	* [相关快捷键](#%EF%B8%8F相关快捷键)
	* [附：关于Vim的标签跳转](#附关于vim的标签跳转)

---

## 环境需求
如果你习惯使用Vim，需要保证版本号```Vim >= 7.3```；  
如果你习惯使用Neovim，需要保证版本号```Neovim >= 0.7```。

## 主要功能
目录文件树、命令行、文件历史版本管理、底部状态栏、粘贴板历史、代码标签树、文件和内容的模糊检索、代码格式化、代码补全与跳转（Neovim）、代码调试（Neovim）等。  

本套配置中，Vim的定位是**增强版的文本编辑器，而非IDE**；Neovim可以**承担IDE的一部分功能，但也不能完全取代IDE**。  

## 配置我的Vim
[![Vim Logo](https://github.com/vim/vim/raw/master/runtime/vimlogo.gif)](https://www.vim.org)  
切换路径至本仓库目录下，复制本仓库的```.vimrc```作为用户的Vim默认配置文件。
```
cp ./.vimrc ~/.vimrc
```

配置中使用了Vundle作为Vim的插件管理器，按照[官方文档](https://github.com/VundleVim/Vundle.vim)下载Vundle。
```
git clone --depth 1 https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

下载完毕后，进入Vim。此时Vim会报告一系列插件未找到的错误，这是正常现象。按下```<C-c>（即常说的Ctrl+C）```忽略这些错误，接着输入命令```:PluginInstall```来下载安装这些插件。  
主要功能插件的快捷键是```<F2> ~ <F5>```，```<F7> ~ <F9>```。安装完毕后重新进入Vim，即可按动快捷键查看插件是否工作正常。

⚠️注意：  
1. 如果插件下载安装进度过慢或显示某些插件安装失败，请按下```<C-c>```停止安装，然后尝试重新输入命令```:PluginInstall```来下载安装这些插件。
2. 配置文件默认使用加速网站来加快对github的访问，如需更换回原始的github网址，请更改配置文件中的```GITHUB_SITE```变量值，将被注释掉的```GITHUB_SITE```变量值还原。
3. 某些插件需要进行额外的操作才能正常工作（如```<F3>```对应的```Shougo/vimshell.vim```插件），请根据插件提示操作。```Shougo/vimshell.vim```插件需要```cd ~/.vim/bundle/vimproc.vim && make```编译库后才能正常工作。

## 配置我的Neovim
![Neovim](https://raw.githubusercontent.com/neovim/neovim.github.io/master/logos/neovim-logo-300x87.png)  
**Neovim编辑器是对传统Vim编辑器的重构**。Neovim拥有着强大的：
- **可扩展性**——几乎所有主流语言都可以轻松访问Neovim的API，因此大家能够很容易地编写它的插件。Neovim对lua语言的内建支持使得插件可以飞速运行，这让**流畅的**代码补全和语法高亮等功能成为可能。
- **可用性**——Neovim修缮了Vim过时的默认配置（Neovim定制了一套自己的新默认配置），并添加了现代编辑器的新功能，如现代GUI、异步加载和终端模拟器等。

### 安装Neovim
本仓库的Neovim配置文件需要比较新的Neovim版本（大于等于0.7），大多数的包管理器软件源尚未更新该版本，因此需要遵循[官方文档](https://github.com/neovim/neovim/wiki/Installing-Neovim)手动安装。对于Linux系统，执行如下操作来下载Neovim的可执行文件，下载后应当可以直接运行Neovim。
```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage
```
此时Neovim应当开始运行。  

```nvim.appimage```是Neovim的启动程序，可以将其改名为```nvim```放置在```/usr/bin/```目录下（需要sudo权限。```/usr/bin/```目录应当存在于```$PATH```中，操作后所有用户均可使用nvim命令）。
```
chmod +x nvim.appimage
sudo mv ./nvim.appimage /usr/bin/nvim
```
或改名为```nvim```放置在```~/.local/bin/```目录下（无需sudo权限。```~/.local/bin/```应当存在于```$PATH```中，操作后仅当前用户可使用nvim命令）。
```
mv ./nvim.appimage ~/.local/bin/nvim
```
💡如果```nvim.appimage```执行失败（在确认文件已经**完整下载**后，仍然执行失败），可以手动从安装包里解压Neovim相关文件到本地。
```
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version
```
如果要全局安装（需sudo权限），先对相关文件进行移动，再将可执行文件软连接到系统二进制文件目录下，命名为nvim。操作完成后，使用nvim命令便可以启动Neovim。
```
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
nvim
```
💡如果没有sudo权限，可以仅对当前用户安装Neovim。对Ubuntu系统而言，可以将程序数据移动至当前用户```$HOME```下的```.local/```目录（这是Ubuntu默认用于存放当前用户应用数据的位置）；然后将可执行文件软连接至```~/.local/bin/nvim```（```~/.local/bin/```目录是Ubuntu系统默认用于存放当前用户可执行文件的位置，并应当默认存在于当前用户的```$PATH```中）。
```
mv squashfs-root ~/.local/
ln -s ~/.local/squashfs-root/AppRun ~/.local/bin/nvim
nvim
```

### 配置Neovim
切换路径至本仓库目录下，复制本仓库的```init.vim```作为用户的Neovim默认配置文件（Neovim用户默认配置文件为```~/.config/nvim/init.vim```）。
```
mkdir -p ~/.config/nvim/
cp ./init.vim ~/.config/nvim/init.vim
```
在终端输入```nvim```进入Neovim，此时将自动开始下载插件管理器```plug.vim```。下载完毕后Neovim会报告一系列插件未找到的错误，这是正常现象。按下```<C-c>```忽略这些错误，接着输入命令```:PlugInstall```安装所有插件。  
主要功能插件的快捷键是```<F2> ~ <F9>```。安装完毕后重新进入Neovim，即可按动快捷键查看插件是否工作正常。

⚠️注意：  
1. 如果插件下载安装进度过慢或显示某些插件安装失败，请退出Neovim，然后尝试重新打开Neovim输入命令```:PlugInstall```来下载安装这些插件。
2. 配置文件默认使用加速网站来加快对github的访问，如需更换回原始的github网址，请更改配置文件中的```GITHUB_RAW```与```GITHUB_SITE```变量值，将被注释掉的变量值还原。在改变网址后所有已安装插件都需要更新，输入命令```:PlugClean```和```:PlugInstall```来重新下载安装插件。

## 主要快捷键
### ✅描述约定
- ```<F2>```表示短促地按一下```F2```功能键。  
有些电脑的功能键需要先按住```fn```键才能启用，建议设置成不需要按```fn```键就能直接用。  
- ```<C-p>```表示先按住```Ctrl```不松手，再按下小写的```p```。  
- ```F```（大写```F```）表示先按住```Shift```不松手，再按下小写的```f```，此时输出大写的```F```。

### ⌨️键位与功能
- **```<F2>``` 文件浏览器**  
以文件树的方式查看当前目录。可以在其中打开/删除/新建文件等。再按一次快捷键可关闭窗口。
- **```<F3>``` 系统命令行**  
在编辑器内部打开一个系统命令行。支持```Tab```命令补全，```<C-p>```上翻历史记录，```<C-n>```下翻。再按一次快捷键可关闭窗口。
- **```<F4>``` 文件历史版本**  
展示当前文件撤销和重做的历史记录。历史记录可以分叉，并且可以随时将文件内容回退到选定历史版本。再按一次快捷键可关闭窗口。
- **```<F5>``` 底部状态栏**  
开启一个漂亮的底部状态栏。可以显示当前文件的详细信息，如行列号/文件路径/编码/当前按键等。再按一次快捷键可关闭窗口。
- **```<F6>``` 【Neovim】代码调试器**  
**仅适用于Neovim**。打开代码调试器，对当前脚本或指定程序进行调试。<br/>🟨本插件会调用系统中相应的代码调试工具，如```gdb（需要安装GCC）```，``` pdb（需要安装Python）```等，满足依赖后该插件即可调试对应的代码。
- **```<F7>``` 粘贴板历史**  
列举最近在**编辑器内部**复制的所有内容。输入数字或双击对应行，即可粘贴相应内容。再按一次快捷键可关闭窗口。
- **```<F8>``` 代码标签树**  
分析并展示当前代码文件的所有标签（指函数/变量/包含文件/宏等），依赖于外部```ctags```程序。鼠标双击/键盘回车某个标签，即可跳转至标签定义位置。再按一次快捷键可关闭窗口。<br/>🟨本插件需要提供```ctags```程序方可工作，```ctags```可通过包管理器安装。```ctags```命令一般由```universal-ctags```包和```exuberant-ctags```包提供，该插件同时兼容两者，但强烈建议安装更加先进的```universal-ctags```。
- **```<F9>``` 模糊检索器**  
快速对文件名/文件内容/标签等信息进行**模糊检索**。无须记住整个文件路径，只需输入文件路径和文件名的**几个字母**，即可交互式地进行查找。若要查询tags标签，需要在当前目录下提供```ctags```生成的标签文件——在项目根目录下执行```ctags -R .```即可生成整个项目的tags文件。<ul><li>**Vim**：基于```kien/ctrlp.vim```插件。默认状态下为文件名查找模式，输入大致的文件路径和名称即可进行模糊查找。```方向键```选择查询结果，```回车键```打开选择的文件。```<C-f>```和```<C-b>```切换查找的类别（files文件/tags标签等）。<br/>🟦默认在当前工作目录下进行查找。如需查询其他目录下的内容，可手动输入命令```:CtrlP 目录名```。<br/>🟦额外安装文件内容检索工具[ag](https://github.com/ggreer/the_silver_searcher)，可提高本插件的检索效率。</li><li>**Neovim**：基于```fzf```工具的相关插件。```<F9>```进入后先输入查找的类别（files文件/grep文件内容/tags标签等），按```回车键```确认后再输入查找内容，进行模糊检索（如果是grep搜索文件内容，回车后在屏幕下方的```Grep For```后输入要搜索的文件内容，回车后即可进行搜索），检索完毕后按```方向键```选择结果，```回车键```打开选择的文件。<br/>🟦默认在当前工作目录下进行查找。如需查询其他目录下的内容，可手动输入命令```:FZF 目录名```或```:FzfLua 查询类别 cwd=目录名```。<br/>🟦额外安装文件内容检索工具[rg](https://github.com/BurntSushi/ripgrep)和文件位置搜索工具[fd](https://github.com/sharkdp/fd)，可提高本插件的检索效率。</li></ul>

## 辅助快捷键
### ✅描述约定
- ```<Leader>t```表示先短促地按一下```反斜杠\```（即Leader键），紧接着再短促地按一下小写的```t```。  
两次按键间隔要短，不然编辑器会认为这是两次不相关的输入。  
- ```<Leader>F```表示先短促地按一下```反斜杠\```，紧接着再短促地按一下大写的```F```（按```Shift```不松手并按```f```）。

### ⌨️键位与功能
- **```<Leader>l``` 空白字符开关**  
展示/隐藏空白字符，按多次可在展示/隐藏间来回切换。
- **```<Leader>p``` 粘贴模式开关**  
进入/退出```粘贴模式```。在```粘贴模式```下，自动缩进和一些插件功能会自动关闭。对于Vim来说，需要从**外部**（如博客等）粘贴内容进入编辑器时，如果内容包含复杂的换行和缩进，建议先切换成```粘贴模式```再粘贴，以避免错误激活自动缩进和插件功能。按多次可在进入/退出```粘贴模式```间来回切换。
- **```<Leader>t``` 制表符/空格切换**  
将```<Tab>```的输入在空格和```制表符\t```之间切换，本配置文件默认配置```<Tab>```的输入为四个空格。
- **```<Leader>f``` 代码局部格式化**  
美化代码的指定行/块。需要外部的软件支持。
- **```<Leader>F``` 代码全局格式化**  
美化整个代码文件。需要外部的软件支持。
- **```<Leader>s``` 删除多余空格**  
删除所有多余的空格。在行尾多余的空格会被红色高亮显示，该操作可以快速删除这些多余空格。<br/>🟨在某些语言（如Markdown）的语法中，行尾空格是有实际语法意义的，这种情况下请不要轻易使用本快捷键。
- **```<Leader>a``` 检索光标处单词**  
检索当前光标处单词（应该会用<u>下划线</u>标出）在其它文件中出现的位置。<ul><li>**Vim**：基于```mileszs/ack.vim```插件。<br/>🟨需要额外安装文件内容检索工具[ag](https://github.com/ggreer/the_silver_searcher)，才能正常使用此功能。</li><li>**Neovim**：基于```fzf```工具的相关插件。<br/>🟦额外安装文件内容检索工具[rg](https://github.com/BurntSushi/ripgrep)，可提高本插件的检索效率。</li></ul>
- **```<Leader>A``` 检索给定单词**  
检索给定单词在其它文件中出现的位置。按下此快捷键后，输入要查找的内容，会返回该内容在其它文件中出现的位置。相关该功能的依赖需求同上。
- **```<Leader>d``` LSP代码诊断开关**  
【Neovim】展示/隐藏LSP的代码诊断信息。
- **```<Leader>ve``` 编辑配置文件**  
快速打开并编辑Vim/Neovim配置文件。
- **```<Leader>vs``` 保存并更新配置**  
保存当前已打开的所有可写文件，并使Vim/Neovim配置马上生效。

更多关于快捷键的信息，请见配置文件最后的```hotkeys```部分。

## 【Neovim】代码补全、内容跳转等
### 🔍LSP 语言服务器协议
**语言服务器协议（Language Server Protocol，简称LSP）是由微软等机构，为了统一不同编辑器上各种语言的代码补全、内容跳转等功能，而提出的协议**。  
在过去，每个不同的编辑器（或IDE）都需要编写一套自己的业务逻辑来支持各种编程语言的代码补全、内容跳转等功能——**假如市面上有```m```个编辑器（或IDE），每个都要支持```n```种编程语言，那就一共需要编写```m*n```套业务逻辑**，来实现不同编辑器上各种语言的代码补全等功能，非常麻烦。
![No LSP vs LSP](https://code.visualstudio.com/assets/api/language-extensions/language-server-extension-guide/lsp-languages-editors.png)
**LSP**简化了这个过程，协议约定——  
先有一套LSP通信协议规范，我们只需要为这```n```种编程语言设计各自的**语言服务器**（服务器运行着针对自己语言的代码补全等算法），再为市面上的```m```个编辑器（或IDE）设计它们的**客户端**（客户端向服务器发送代码补全的请求，然后把收到的结果展示给用户），最后让服务器和客户端按照LSP规定通信。  
**同样的问题，LSP的解决方案只需要编写```m+n```套逻辑，统一而简洁。**

### 🆅 安装本地LSP服务器并配置Neovim LSP客户端
Neovim提供了内置的LSP客户端，配合系统里下载好的LSP语言服务器，我们便可以在Neovim中体验到流畅的代码补全、内容跳转等功能。下面以配置Python3语言的代码自动补全等功能为例。  
1. 下载并安装Python3的LSP语言服务器。  
通过查询[LSP语言服务器列表](https://github.com/williamboman/nvim-lsp-installer#available-lsps)，我们采用[```pylsp```](https://github.com/python-lsp/python-lsp-server)程序包作为Python3的语言服务器。按照该项目的```README.md```说明，使用pip进行全套工具安装。安装完毕后，终端中```pylsp -V```命令应当可用。
```
pip install "python-lsp-server[all]"
```
2. 在Neovim的```init.vim```配置文件中，注册```pylsp```语言服务器。  
在配置文件中找到```Language Server Protocol (LSP) server configs```一栏，在其中的```MY_LSP_SERVER_LIST```列表里向后添加一行新的语言服务器。保存后退出。
```
-- register your installed LSP server here
MY_LSP_SERVER_LIST = {
    其它语言服务器,
    "pylsp",
}
```
3. 使用Neovim打开一个Python3代码文件，在Neovim中输入命令```:LspInfo```，此时应当显示Neovim的LSP客户端已经找到了本地的```pylsp```服务器。尝试输入代码，自动补全和函数签名等功能应当自动开始工作。

### ⌨️相关快捷键
|按键|功能|
|-|-|
|```gD```|跳转到当前光标处词条（会用<u>下划线</u>标出）的**声明**位置。按```<C-t>```跳转回去。|
|```gd```|跳转到当前光标处词条的**定义**位置。按```<C-t>```跳转回去。|
|```K```|展示当前光标处词条的**详细信息**（如变量的类别信息/函数的签名/库的介绍等）。|
|```gr```|展示当前光标处词条的所有**引用**。|
|```gs```|展示当前光标处**函数实参**对应的**函数形参与函数签名**。|
|```gi```|展示当前光标处词条的所有**实现**。|
|```gt```|跳转到当前光标处**类别**的**定义**位置。按```<C-t>```跳转回去。|

### 附：关于Vim的标签跳转
Vim虽然没有对LSP的内建支持，但仍原生支持代码的标签跳转功能。具体操作如下：  
1. 先在项目代码的根目录下执行```ctags -R .```，递归生成整个项目的tags标签文件。
2. 接着**在项目根目录下**打开项目中任何一个代码文件，在要查询定义的词条处按下```<C-]>```。
3. 如果tags文件中包含了该词条的信息，此时Vim将跳转到该词条的定义处（可以跨代码文件跳转）。
4. 按```<C-t>```，可回到上一次跳转前的位置。如果之前进行了多次跳转，按多次```<C-t>```可以一级一级地回去。
