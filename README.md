# dotfiles

## How to clone

### 一回でcloneする

```console
$ git clone --recursive https://github.com/Riliumph/dotfiles.git
```

### submoduleを動かす

`git submodule`はディレクトリをgit内部で特殊判定しているに過ぎない。  
あくまでLinuxの空間ではディレクトリなので`git clone`後は空ディレクトリである。

まず、`git`にはsubmoduleを認識してもらう

```console
$ git submodule init
```

次にsubmodule部分を更新する

```console
$ git submodule update
```

これで空ディレクトリだったところにcloneされてくる。
