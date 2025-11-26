import SwiftUI

struct ContentView: View {
    @State private var showHTML = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("ローカルHTML表示サンプル")
                    .font(.title2)

                Button(action: { showHTML.toggle() }) {
                    Text(showHTML ? "閉じる" : "index.html を開く")
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.blue.opacity(0.85))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .animation(.easeInOut, value: showHTML)

                if showHTML {
                    // WebViewを表示 (index.html はアプリバンドル内に追加しておく)
                    WebView(htmlFileName: "index", loadHTML: true)
                        .frame(maxWidth: .infinity, maxHeight: 400)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                        .transition(.opacity)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("HTML表示")
        }
    }
}

#Preview {
    ContentView()
}
