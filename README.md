# ChordScroller

Mac用の「コード譜検索 + 自動縦スクロール」アプリです。

## 初版機能
- 曲名 / アーティスト名でWeb検索
- 検索結果をアプリ内ブラウザで表示
- コード譜サイトをそのまま閲覧
- 任意速度の自動縦スクロール
- 再生 / 一時停止
- 500px単位で上下移動
- ページ先頭へ戻る
- 戻る / 進む / 再読込

## 設計上のポイント
第三者サイトのコード譜本文を無断コピーして再配布するのではなく、元サイトをWKWebViewで直接表示します。
これにより、初版ではスクレイピングを避けつつ「検索→表示→演奏用オートスクロール」を実現します。

## ビルド
macOS 13以上 / Xcode Command Line Tools が必要です。

```bash
cd ChordScroller
bash scripts/build-mac.sh
open build/ChordScroller.app
```

## インストール
ビルド後、次のコマンドで「アプリケーション」へコピーできます。

```bash
ditto build/ChordScroller.app /Applications/ChordScroller.app
open /Applications/ChordScroller.app
```

## 次に追加できる機能
- お気に入り
- 曲ごとのスクロール速度保存
- BPM連動スクロール
- Bluetoothフットスイッチ / MIDIペダル操作
- 全画面演奏モード
- ページ内の広告やヘッダーを一時非表示にする「演奏集中モード」
- コード譜をユーザーが貼り付けた場合のTranspose
