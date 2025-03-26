
import Foundation
import SwiftUI



struct HelperForLoadingManager: View {
    @StateObject var mainVM: BaseViewModel
    
    init(ctrl: BaseViewModel) {
        _mainVM = StateObject(wrappedValue: ctrl)
    }
    
    var body: some View {
        ZStack {
            HolderHelper(vm: mainVM)
            .opacity(mainVM.loaderState == .done ? 1 : 0.5)
            if case .preload(let p) = mainVM.loaderState {
                GeometryReader { geo in
                    DynamicLoader(progress: p)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .background(Color.black)
                }
            } else if case .error(let e) = mainVM.loaderState {
                Text("Error: \(e.localizedDescription)").foregroundColor(.red)
            } else if case .networkError = mainVM.loaderState {
                Text("")
            }
        }
    }
}
