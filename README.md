# RuboCop Correct Config

## usage

``` shellsession
$ ruby rubocop-correct-config [-o | --override] <config-file>
```

## 概要

RuboCop のバージョンアップをするとしばしば設定ファイル (デフォルトで .rubocop.yml) のエントリが変わります。RuboCop 自身が直し方を示唆してくれるとはいえ面倒です。

このプログラムは RuboCop が提示してくる設定ファイルに関するエラーや警告を用いて設定ファイルを修正するものです。

## オプション

* [`-o | --override`] 入力ファイルを修正結果で上書きします
* `<config-file>` 入力ファイルの指定です。省略時は `./.rubocop.yml` が指定されたものとみなします
