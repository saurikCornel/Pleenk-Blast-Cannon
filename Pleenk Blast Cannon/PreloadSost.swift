
import Foundation
import SwiftUI
import WebKit
import Foundation



enum PreloadSost: Equatable {
    case unknown
    case preload(progress: Double)
    case done
    case error(Error)
    case networkError
    
    static func == (lhs: PreloadSost, rhs: PreloadSost) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown), (.done, .done), (.networkError, .networkError):
            return true
        case (.preload(let lp), .preload(let rp)):
            return lp == rp
        case (.error, .error):
            return true
        default:
            return false
        }
    }
}

struct HolderHelper: UIViewRepresentable {
    @ObservedObject var vm: BaseViewModel
    
    func makeCoordinator() -> ManipulateRenderDelegate {
        ManipulateRenderDelegate(owner: self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        // Настройка для отключения кэширования
        config.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        
        let view = WKWebView(frame: .zero, configuration: config)
        
        // Set the background color to #141f2b
        view.backgroundColor = UIColor(hex: "#141f2b")
        view.isOpaque = false // Optional: Ensures the background color is fully applied
        
        // Очистка всех существующих данных кэша
        let dataTypes = Set([WKWebsiteDataTypeDiskCache,
                           WKWebsiteDataTypeMemoryCache,
                           WKWebsiteDataTypeCookies,
                           WKWebsiteDataTypeLocalStorage])
        
        WKWebsiteDataStore.default().removeData(ofTypes: dataTypes,
                                              modifiedSince: Date.distantPast) {
            debugPrint("Cache cleared on creation")
        }
        
        debugPrint("Renderer: \(vm.url)")
        view.navigationDelegate = context.coordinator
        vm.setWebView(view)
        return view
    }
    
    func updateUIView(_ view: WKWebView, context: Context) {
        // Очистка кэша при обновлении представления
        let dataTypes = Set([WKWebsiteDataTypeDiskCache,
                           WKWebsiteDataTypeMemoryCache,
                           WKWebsiteDataTypeCookies,
                           WKWebsiteDataTypeLocalStorage])
        
        WKWebsiteDataStore.default().removeData(ofTypes: dataTypes,
                                              modifiedSince: Date.distantPast) {
            debugPrint("Cache cleared on update")
        }
        
        debugPrint("RendererUpdate: \(view.url?.absoluteString ?? "nil")")
    }
}

// UIColor extension to handle hex color codes
extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
