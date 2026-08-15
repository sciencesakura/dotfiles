# tmux 環境構築の課題

## tpack で tmux-mem-cpu-load をインストールするとバイナリが作られない【未調査】

`tmux-mem-cpu-load.plugin.tmux` の source が走ってバイナリがビルドされることを期待するが, tpack TUIからのインストールや `tpack source` ではビルドされなかった.

手動で `./tmux-mem-cpu-load.plugin.tmux` して暫定対応.

## tpack でインストールした tmux-mem-cpu-load が tmux-powerline で認識されない

tpack のプラグインインストールディレクトリが tpm 非互換なため `$TMUX_PLUGIN_MANAGER_PATH/<plugin repository name>` を参照している segment が動かなくなる.

tpack では完全修飾したリポジトリ名の SHA256 の先頭12文字をディレクトリ名に付与している. 例えば `github.com/thewtex/tmux-mem-cpu-load` は `$TMUX_PLUGIN_MANAGER_PATH/tmux-mem-cpu-load-17b22c39a668` にインストールされる.

参考） `printf 'github.com/thewtex/tmux-mem-cpu-load' | sha256sum -` で検証

alias 指定して対応.

```sh
set-option -g @plugin 'thewtex/tmux-mem-cpu-load alias=tmux-mem-cpu-load'
```
