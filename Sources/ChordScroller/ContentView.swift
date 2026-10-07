import SwiftUI

struct ContentView: View {
    @StateObject private var model = BrowserModel()

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 10) {
                HStack(spacing: 8) {
                    TextField("曲名 / アーティスト名  例: Stand By Me Ben E. King", text: $model.query)
                        .textFieldStyle(.roundedBorder)
                        .font(.title3)
                        .onSubmit { model.search() }

                    Button("検索") { model.search() }
                        .keyboardShortcut(.return, modifiers: [.command])
                        .buttonStyle(.borderedProminent)
                }

                HStack(spacing: 10) {
                    Button { model.goBack() } label: { Label("戻る", systemImage: "chevron.left") }
                        .disabled(!model.canGoBack)
                    Button { model.goForward() } label: { Label("進む", systemImage: "chevron.right") }
                        .disabled(!model.canGoForward)
                    Button { model.reload() } label: { Label("再読込", systemImage: "arrow.clockwise") }
                    Button { model.toTop() } label: { Label("先頭", systemImage: "arrow.up.to.line") }

                    Divider().frame(height: 26)

                    Button { model.jumpUp() } label: { Label("少し戻る", systemImage: "arrow.up") }
                    Button { model.toggleScrolling() } label: {
                        Label(model.isScrolling ? "停止" : "自動スクロール", systemImage: model.isScrolling ? "pause.fill" : "play.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    Button { model.jumpDown() } label: { Label("少し進む", systemImage: "arrow.down") }

                    Divider().frame(height: 26)

                    Text("速度")
                    Slider(value: $model.speed, in: 5...240, step: 5)
                        .frame(minWidth: 150, maxWidth: 260)
                    Text("\(Int(model.speed)) px/秒")
                        .monospacedDigit()
                        .frame(width: 88, alignment: .trailing)
                }
                .controlSize(.large)

                HStack {
                    Text(model.statusText)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                    Spacer()
                    if !model.currentURL.isEmpty {
                        Text(model.currentURL)
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                            .lineLimit(1)
                            .truncationMode(.middle)
                            .frame(maxWidth: 450)
                    }
                }
            }
            .padding(12)
            .background(.regularMaterial)

            Divider()
            WebView(model: model)
        }
    }
}
