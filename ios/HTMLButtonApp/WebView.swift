import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let htmlFileName: String
    let loadHTML: Bool

    init(htmlFileName: String, loadHTML: Bool) {
        self.htmlFileName = htmlFileName
        self.loadHTML = loadHTML
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero)
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard loadHTML else { return }
        if let url = Bundle.main.url(forResource: htmlFileName, withExtension: "html") {
            // ローカルHTML読み込み
            uiView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        } else {
            // 失敗時は簡易のHTMLを表示
            let fallback = "<html><body><h3>\(htmlFileName).html が見つかりません</h3></body></html>"
            uiView.loadHTMLString(fallback, baseURL: nil)
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator() }

    class Coordinator: NSObject, WKNavigationDelegate { }
}
