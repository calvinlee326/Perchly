import SwiftUI
import WebKit

@main struct MyApp: App {
    @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        Settings { EmptyView() }
    }
}

final class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem!
    private var window: NSWindow!

    func applicationDidFinishLaunching(_ notification: Notification) {
        let hosting = NSHostingView(rootView: ContentView())
        hosting.sizingOptions = [.minSize]

        window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 400, height: 760),
                          styleMask: [.titled, .closable, .miniaturizable, .resizable],
                          backing: .buffered, defer: false)
        window.title = "Perchly"
        window.isReleasedWhenClosed = false
        window.contentView = hosting
        window.center()
        window.setFrameAutosaveName("PerchlyWindow")

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        statusItem.button?.image = NSImage(systemSymbolName: "camera", accessibilityDescription: "Perchly")
        statusItem.button?.target = self
        statusItem.button?.action = #selector(toggleWindow)

        showWindow()
    }

    @objc private func toggleWindow() {
        if window.isVisible && window.isKeyWindow { window.orderOut(nil) } else { showWindow() }
    }

    private func showWindow() {
        window.makeKeyAndOrderFront(nil)
        NSApp.activate()
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            WebView(url: URL(string: "https://www.instagram.com/?hl=en")!)
            Button("Quit") { NSApplication.shared.terminate(nil) }
                .keyboardShortcut("q")
                .padding(6)
        }
        .frame(minWidth: 360, minHeight: 500)
    }
}

struct WebView: NSViewRepresentable {
    let url: URL

    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeNSView(context: Context) -> WKWebView {
        let web = PausingWebView()
        web.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Mobile/15E148 Safari/604.1"
        web.uiDelegate = context.coordinator
        web.navigationDelegate = context.coordinator
        web.load(URLRequest(url: url))
        return web
    }

    func updateNSView(_ web: WKWebView, context: Context) {}

    final class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        private static let inAppHosts = ["instagram.com", "facebook.com"]

        private func isWeb(_ url: URL) -> Bool { url.scheme == "http" || url.scheme == "https" }

        private func isInApp(_ url: URL) -> Bool {
            guard let host = url.host?.lowercased() else { return true }
            return Self.inAppHosts.contains { host == $0 || host.hasSuffix("." + $0) }
        }

        // Links that open a new tab (target=_blank, window.open)
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration,
                     for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if let url = navigationAction.request.url, isWeb(url) {
                if isInApp(url) { webView.load(navigationAction.request) } else { NSWorkspace.shared.open(url) }
            }
            return nil
        }

        // Leaving Instagram in the main frame goes to the default browser
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if navigationAction.targetFrame?.isMainFrame == true, let url = navigationAction.request.url,
               isWeb(url), !isInApp(url) {
                NSWorkspace.shared.open(url)
                decisionHandler(.cancel)
                return
            }
            decisionHandler(.allow)
        }

        // <input type="file"> for posting photos
        func webView(_ webView: WKWebView, runOpenPanelWith parameters: WKOpenPanelParameters,
                     initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping ([URL]?) -> Void) {
            guard let window = webView.window else { completionHandler(nil); return }
            let panel = NSOpenPanel()
            panel.allowsMultipleSelection = parameters.allowsMultipleSelection
            panel.canChooseDirectories = parameters.allowsDirectories
            panel.beginSheetModal(for: window) { completionHandler($0 == .OK ? panel.urls : nil) }
        }
    }
}

// Pauses videos when the window is hidden or minimized, otherwise Reels keep playing sound
final class PausingWebView: WKWebView {
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        NotificationCenter.default.removeObserver(self, name: NSWindow.didChangeOcclusionStateNotification, object: nil)
        guard let window else { pauseAllMediaPlayback(); return }
        NotificationCenter.default.addObserver(self, selector: #selector(occlusionChanged),
                                               name: NSWindow.didChangeOcclusionStateNotification, object: window)
    }

    @objc private func occlusionChanged() {
        guard let window, !window.isVisible || window.isMiniaturized else { return }
        pauseAllMediaPlayback()
    }
}
