//
//  WebViewController.swift
//  Project16
//
//  Created by Carlos David on 6/2/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    static let viewIdentifier = "websiteController"

    var webView: WKWebView!
    var progressView: UIProgressView!
    var cityName: String?

    var goBackButton: UIBarButtonItem!
    var goForwardButton: UIBarButtonItem!

    override func loadView() {
        super.loadView()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let cityName = cityName {
            let url = URL(string: "https://wikipedia.org/wiki/\(cityName)")!
            webView.load(URLRequest(url: url))
        }

        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward), options: .new, context: nil)

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                            target: webView,
                                                            action: #selector(webView.reload))

        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)

        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: webView, action: nil)

        goBackButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                       style: .plain, target: webView, action: #selector(webView.goBack))
        goBackButton.isEnabled = false

        goForwardButton = UIBarButtonItem(image: UIImage(systemName: "chevron.forward"),
                                          style: .plain, target: webView, action: #selector(webView.goForward))
        goForwardButton.isEnabled = false

        toolbarItems = [goBackButton, goForwardButton, spacer, progressButton]
        navigationController?.isToolbarHidden = false
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack))
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward))
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case "estimatedProgress":
            progressView.progress = Float(webView.estimatedProgress)
            progressView.isHidden = progressView.progress == 1.0
        case "canGoBack":
            goBackButton.isEnabled = webView.canGoBack
        case "canGoForward":
            goForwardButton.isEnabled = webView.canGoForward
        default:
            break
        }
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if let host = url?.host {
            if host.contains("wikipedia.org") {
                decisionHandler(.allow)
                return
            }

            let ac = UIAlertController(title: "Restricted website",
                                       message: "The site located at \(host) is not allowed",
                                       preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true)
        }
        decisionHandler(.cancel)
    }
}
