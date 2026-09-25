import SwiftUI
import Playgrounds


struct ContentView: View {
    @StateObject var viewModel = ViewModel()

    var body: some View {
        VStack {
            SearchBar(viewModel: viewModel)
            WebView(viewModel: viewModel)
            BottomBar(viewModel: viewModel)
        }
        .sheet(isPresented: $viewModel.shouldShowShareSheet) {
            if let url: URL = URL(string: "https://\(viewModel.urlString)") {
                ShareSheet(activityItems: [url])
            }
        }
    }
}
#Preview {
    ContentView()
}
