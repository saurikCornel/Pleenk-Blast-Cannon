//
//  BaseViewModel.swift
//  Pleenk Blast Cannon
//
//  Created by alex on 3/26/25.
//

import Foundation
import SwiftUI
import WebKit


class BaseViewModel: ObservableObject {
    @Published var loaderState: PreloadSost = .unknown
    let url: URL
    private var wv: WKWebView?
    private var regr: NSKeyValueObservation?
    private var progreess: Double = 0.0
   
    
    init(url: URL) {
        self.url = url
        debugPrint("Model initialized with URL: \(url)")
    }
    
    func setWebView(_ webView: WKWebView) {
        self.wv = webView
        observeProgress(webView)
        loadRequest()
        debugPrint("WebView set in Model")
    }
    
    func loadRequest() {
        guard let webView = wv else {
            debugPrint("WebView is nil, cannot load yet")
            return
        }
        let request = URLRequest(url: url, timeoutInterval: 15.0)
        debugPrint("Loading request for URL: \(url)")
       
        DispatchQueue.main.async { [weak self] in
            self?.loaderState = .preload(progress: 0.0)
            self?.progreess = 0.0
        }
        webView.load(request)
    }
    
    private func observeProgress(_ webView: WKWebView) {
        regr = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
            let progress = webView.estimatedProgress
            debugPrint("Progress updated: \(Int(progress * 100))%")
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if progress > self.progreess {
                    self.progreess = progress
                    self.loaderState = .preload(progress: self.progreess)
                }
                if progress >= 1.0 {
                    self.loaderState = .done
                }
            }
        }
    }
    
    func updateNetworkStatus(_ isConnected: Bool) {
        if isConnected && loaderState == .networkError {
            loadRequest()
        } else if !isConnected {
            DispatchQueue.main.async { [weak self] in
                self?.loaderState = .networkError
            }
        }
       
    }
}
