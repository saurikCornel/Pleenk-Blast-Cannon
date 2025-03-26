


import Foundation
import WebKit

class ManipulateRenderDelegate: NSObject, WKNavigationDelegate {
    let owner: HolderHelper
    var redirectFlag = false
  
    init(owner: HolderHelper) {
        self.owner = owner
        debugPrint("Control init")
    }
    
    private func updateState(_ state: PreloadSost) {
        DispatchQueue.main.async { [weak self] in
            self?.owner.vm.loaderState = state
        }
    }
    
    func webView(_ wv: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
        debugPrint("StartNav: \(wv.url?.absoluteString ?? "n/a")")
        if !redirectFlag { updateState(.preload(progress: 0.0)) }
    }
    
    func webView(_ wv: WKWebView, didCommit _: WKNavigation!) {
        redirectFlag = false
        debugPrint("CommitNav: \(Int(wv.estimatedProgress * 100))%")
    }
    
    func webView(_ wv: WKWebView, didFinish _: WKNavigation!) {
        debugPrint("EndNav: \(wv.url?.absoluteString ?? "n/a")")
        updateState(.done)
    }
    
    func webView(_ wv: WKWebView, didFail _: WKNavigation!, withError e: Error) {
        debugPrint("FailNav: \(e)")
        updateState(.error(e))
    }
    
    func webView(_ wv: WKWebView, didFailProvisionalNavigation _: WKNavigation!, withError e: Error) {
        debugPrint("ProvFailNav: \(e)")
        updateState(.error(e))
    }
    
    func webView(_ wv: WKWebView, decidePolicyFor action: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if action.navigationType == .other && wv.url != nil {
            redirectFlag = true
            debugPrint("RedirNav: \(action.request.url?.absoluteString ?? "n/a")")
        }
        decisionHandler(.allow)
    }
}
