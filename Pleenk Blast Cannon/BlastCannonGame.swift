
import Foundation

import SwiftUI

struct BlastCannonGame: View {
    let url: URL = .init(string: "https://pleenkblastcannon.top/play/")!
    var body: some View {
        HelperForLoadingManager(ctrl: .init(url: url))
            .background(Color(hex: "#141f2b").ignoresSafeArea())
    }
}


#Preview {
    BlastCannonGame()
}
