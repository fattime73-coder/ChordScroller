import Foundation
import WebKit

@MainActor
final class BrowserModel: ObservableObject {
    let webView: WKWebView

    @Published var query: String = ""
    @Published var speed: Double = 40
    @Published var isScrolling = false
    @Published var statusText = "曲名やアーティスト名を入力してください"
    @Published var canGoBack = false
    @Published var canGoForward = false
    @Published var currentURL: String = ""

    private var timer: Timer?

    init() {
        let config = WKWebViewConfiguration()
        config.websiteDataStore = .default()
        webView = WKWebView(frame: .zero, configuration: config)
        webView.allowsMagnification = true
        webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 Version/17.0 Safari/605.1.15"
    }

    deinit {
        timer?.invalidate()
    }

    func search() {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            statusText = "検索語を入力してください"
            return
        }

        stopScrolling()
        let searchTerm = "\(trimmed) chords"
        guard let encoded = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://www.google.com/search?q=\(encoded)") else { return }
        webView.load(URLRequest(url: url))
        statusText = "「\(trimmed)」のコード譜を検索中…"
    }

    func goBack() {
        stopScrolling()
        if webView.canGoBack { webView.goBack() }
    }

    func goForward() {
        stopScrolling()
        if webView.canGoForward { webView.goForward() }
    }

    func reload() {
        stopScrolling()
        webView.reload()
    }

    func toggleScrolling() {
        isScrolling ? stopScrolling() : startScrolling()
    }

    func startScrolling() {
        guard !isScrolling else { return }
        isScrolling = true
        statusText = "自動スクロール中"
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 30.0, repeats: true) { [weak self] _ in
            guard let self else { return }
            let step = max(0.2, self.speed / 30.0)
            self.webView.evaluateJavaScript("window.scrollBy(0, \(step));")
        }
        if let timer {
            RunLoop.main.add(timer, forMode: .common)
        }
    }

    func stopScrolling() {
        timer?.invalidate()
        timer = nil
        if isScrolling {
            statusText = "一時停止"
        }
        isScrolling = false
    }

    func jumpUp() {
        stopScrolling()
        webView.evaluateJavaScript("window.scrollBy({top: -500, behavior: 'smooth'});")
    }

    func jumpDown() {
        stopScrolling()
        webView.evaluateJavaScript("window.scrollBy({top: 500, behavior: 'smooth'});")
    }

    func toTop() {
        stopScrolling()
        webView.evaluateJavaScript("window.scrollTo({top: 0, behavior: 'smooth'});")
    }

    func updateNavigationState() {
        canGoBack = webView.canGoBack
        canGoForward = webView.canGoForward
        currentURL = webView.url?.absoluteString ?? ""
    }
}
