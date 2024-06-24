import SwiftUI

struct PadsView: View {
    let personas: [Persona]
    @Binding var selectedPersonaId: UUID?
    let spacing: CGFloat = 14
    let rows: Int = 3
    let columns: Int = 3

    var body: some View {
        VStack(spacing: spacing) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: spacing) {
                    ForEach(0..<columns, id: \.self) { column in
                        let index = row * columns + column
                        if index < personas.count {
                            PadButton(selectedPersonaId: $selectedPersonaId, persona: personas[index])
                                .aspectRatio(5/3, contentMode: .fit)
                            
                        } else {
                            BlankPad()  // Renders a blank pad if there are not enough personas
                                .aspectRatio(5/3, contentMode: .fit)
                        }
                    }
                }
            }
        }
        .padding(spacing)
    }
}

struct BlankPad: View {
    var body: some View {
        PadButton.defaultPadBackground
            .aspectRatio(5/3, contentMode: .fit)  // Ensure the aspect ratio matches the persona pads
    }
}

struct PadButton: View {
    @Binding var selectedPersonaId: UUID?
    var persona: Persona
    @State private var isTouched = false // Track touch state

    var body: some View {
        ZStack(alignment: .topLeading) {
            padBackground
            textView
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .aspectRatio(5/3, contentMode: .fit)  // Enforces aspect ratio strictly
        .contentShape(Rectangle()) // Makes the entire ZStack tappable
        .onTapGesture {
            self.selectedPersonaId = persona.id
        }
        .onLongPressGesture(minimumDuration: 0.05, pressing: { isPressing in
            self.isTouched = isPressing
        }, perform: {})
    }

    private var padBackground: some View {
        Group {
            if selectedPersonaId == persona.id {
                activePadBackground
            } else if isTouched {
                touchedPadBackground
            } else {
                Self.defaultPadBackground
            }
        }
    }

    private var textView: some View {
        VStack {
            Text(persona.name)
                .font(.caption)
                .lineLimit(1)  // Ensures text does not wrap to multiple lines
                .truncationMode(.tail)
                .frame(maxWidth: 70)  // Constrain text width
                .foregroundColor(
                    Color(
                        hex: selectedPersonaId == persona.id
                        ? "993A18"
                        : "777777"
                    )
                )
        }
        .padding(.top, 12)
    }

    private var activePadBackground: some View {
        RoundedRectangle(cornerRadius: 15)
            .stroke(Color(hex: "704518"), lineWidth: 1)
            .fill(
                RadialGradient(
                    gradient: Gradient(colors: [Color(hex: "EE7D48"), Color(hex: "F7CD8B")]),
                    center: .center,
                    startRadius: 10,
                    endRadius: 70
                )
            )
            .overlay(
                // Inner light stroke
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.3),
                                Color.white.opacity(0),
                                Color(hex: "EE7D48").opacity(0.5)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
                    .blendMode(.overlay)
            )
            .shadow(color: Color(hex: "EE7D48").opacity(0.8), radius: 5, x: 0, y: 0)
            .shadow(color: Color(hex: "EE7D48").opacity(0.3), radius: 5, x: 0, y: 5)

    }

    private var touchedPadBackground: some View {
        RoundedRectangle(cornerRadius: 15)
            .stroke(Color(hex: "666666"), lineWidth: 1)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: "EFEFEF"), Color(hex: "FDFDFD")]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray.opacity(0.7), lineWidth: 2)
                    .blur(radius: 6)
                    .offset(x: 6, y: 6)
                    .mask(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.7)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white.opacity(0.9), lineWidth: 2)
                    .blur(radius: 6)
                    .offset(x: -6, y: -6)
                    .mask(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                                startPoint: .bottomTrailing,
                                endPoint: .topLeading
                            ))
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black.opacity(0.25), lineWidth: 10)
                    .blur(radius: 10)
                    .mask(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.5)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .padding(4)
                    )
            )
    }

    static var defaultPadBackground: some View {
        RoundedRectangle(cornerRadius: 15)
            .stroke(Color(hex: "666666"), lineWidth: 1)
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: "EEEEEE"), Color(hex: "EFEFEF")]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 3)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
                    .blur(radius: 1)
                    .offset(x: -1, y: -1)
                    .mask(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [Color.clear, Color.white]),
                                startPoint: .bottomTrailing,
                                endPoint: .topLeading
                            ))
                    )
            )
    }
}

struct PadsView_Previews: PreviewProvider {
    @State static var selectedPersonaId: UUID? = defaultPersonas[2].id // Assuming the third persona is initially selected

    static var previews: some View {
        PadsView(personas: defaultPersonas, selectedPersonaId: $selectedPersonaId)
    }
}
