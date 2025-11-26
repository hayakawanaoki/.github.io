# HTMLButtonApp (iOS SwiftUI サンプル)

ローカルに含めた `index.html` を、画面上のボタンを押したときに `WKWebView` で表示する最小構成サンプルです。

## 構成ファイル
- `HTMLButtonAppApp.swift` : アプリエントリ (@main)
- `ContentView.swift` : ボタンとWebView表示制御
- `WebView.swift` : SwiftUIから使える`WKWebView`ラッパ
- `index.html` : 表示したいHTML (Xcodeで追加してください)

## 手順 (Xcodeで新規プロジェクト作成)
1. Xcodeで iOS App (SwiftUI) プロジェクトを新規作成 (例: プロジェクト名 `HTMLButtonApp`).
2. 生成された `ContentView.swift` と `App` 構成を、ここにあるファイル内容で置き換えるか追加。
3. Finder (またはXcode) で既存の `index.html` をプロジェクトナビゲータへドラッグ&ドロップ。
   - ダイアログで "Add to targets" に現在のターゲットがチェックされていることを確認。
   - `Copy items if needed` を有効にするとプロジェクトに物理コピーされます。
4. `index.html` がターゲットに含まれれば、ビルド時にバンドルへ入ります。
5. 実行すると、画面の「index.html を開く」ボタンで表示・非表示を切り替えできます。

## 注意点
- ローカルHTMLを読み込む際 `Bundle.main.url(forResource: "index", withExtension: "html")` を利用しています。ファイル名が異なる場合は `WebView(htmlFileName: "変更後ファイル名")` を修正してください。
- 読み込み失敗時は簡易的なエラーメッセージHTMLを表示しています。
- JavaScriptやローカル画像/CSSも同じフォルダに入れていれば相対パスで参照可能です。

## 代替表示方法
### Safari (外部ブラウザ)
```swift
if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
    UIApplication.shared.open(url)
}
```
(ローカル`file://`は挙動が制限される場合があるため、基本はWebView表示推奨)

### `SFSafariViewController` (外部URL用)
ローカルファイルではなくリモートURL (例: `https://example.com`) を開くなら:
```swift
import SafariServices

func openRemote(in controller: UIViewController) {
    let url = URL(string: "https://example.com")!
    let safari = SFSafariViewController(url: url)
    controller.present(safari, animated: true)
}
```

### SwiftUIでリモートURLを直接ロード
```swift
WebView(htmlFileName: "index", loadHTML: false) // まず空
// updateUIView内で以下のように改造して urlRequest をロードする例:
// webView.load(URLRequest(url: URL(string: "https://example.com")!))
```
`WebView` を拡張し、モード分岐 (ローカル/リモート) を追加可能です。

## シンプルなリモート専用WebView例 (参考)
```swift
struct RemoteWebView: UIViewRepresentable {
    let url: URL
    func makeUIView(context: Context) -> WKWebView { WKWebView() }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
}
```

## テストポイント
- ボタン押下で表示/非表示がトグルするか。
- ローカル`index.html`のスタイル/画像/スクリプトが正しく適用されるか。
- 読み込めない場合にフォールバック表示が出るか。

## 次の拡張案
- ローディングインジケータ (WKNavigationDelegateでdidStart/didFinish検知)
- エラーハンドリング/再読み込みボタン
- ダークモード対応用のCSS (prefers-color-scheme)
- リンク遷移制御 (外部リンクはSafariに飛ばす)

---
不明点や追加要件があればお知らせください。
