/*
See the LICENSE file for this Package licensing information.

Abstract:
ScribbleLab's own implementation of WKWebView.
 
Copyright (c) 2024 ScribbleLabApp.
*/

import SwiftUI
import WebKit

/// A SwiftUI view representing a web view.
///
/// This view wraps a `WKWebView` and provides functionality to load a web page from a given URL.
/// It also allows controlling the visibility of the navigation bar.
///
/// This view conforms to the `UIViewControllerRepresentable` protocol to integrate with SwiftUI.
///
@available(iOS 17.0, *)
struct SCNWebView: UIViewControllerRepresentable {
    /// The URL of the web page to load.
    let url: String
    
    /// A binding to control the visibility of the navigation bar.
    @Binding var showToolbar: Bool

    /// Creates a coordinator instance to manage the web view's navigation.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    /// Creates a new `UIViewController` instance with a `WKWebView`.
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        viewController.view = webView
        return viewController
    }

    /// Updates the existing `UIViewController` instance with a new URL.
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        guard let webView = uiViewController.view as? WKWebView else {
            return
        }
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        uiViewController.navigationController?.setNavigationBarHidden(!showToolbar, animated: false)
    }

    /// A coordinator class to manage the web view's navigation events.
    class Coordinator: NSObject, WKNavigationDelegate {
        /// The parent `SCNWebView` instance.
        var parent: SCNWebView

        /// Creates a new coordinator with the specified parent view.
        init(_ parent: SCNWebView) {
            self.parent = parent
        }

        /// A delegate method called when the web view finishes loading a web page.
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.readyState") { (result, error) in
                if let readyState = result as? String, readyState == "complete" {
                    DispatchQueue.main.async {
                        self.parent.showToolbar = false
                    }
                }
            }
        }
    }
}
