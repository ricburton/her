import SwiftUI

struct PadsScreen: View {
    @State private var selectedPersonaId: UUID?

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Color.black
                    .frame(maxHeight: .infinity)
                    .overlay(
                        VStack {
                            if let selectedPersonaId = selectedPersonaId, let selectedPersona = defaultPersonas.first(where: { $0.id == selectedPersonaId }) {
                                VStack {
                                    Image(uiImage: selectedPersona.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 140, height: 140)
                                        .clipShape(Circle())
                                        .shadow(color: Color.white.opacity(0.45), radius: 10, x: 0, y: 0)  // Adds a white glow
                                        .padding(.bottom, 16)
                                    Text(selectedPersona.name)
                                        .font(.digital7(size: 28))
                                        .padding(.bottom, 12)
                                        .foregroundColor(.white)
                                    Text(selectedPersona.description)
                                        .foregroundColor(.white)
                                    Text(selectedPersona.systemPrompt)
                                        .foregroundColor(.gray)
                                }
                                .padding(.bottom)
                            }
                        }
                    )
                PadsView(personas: defaultPersonas, selectedPersonaId: $selectedPersonaId)
                    .padding(.bottom, geometry.safeAreaInsets.bottom)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview("Pads Screen") {
    PadsScreen()
}
