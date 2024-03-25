//
//  HalfviewModal.swift
//  Her
//
//  Created by Steven Sarmiento on 3/21/24.
//

import SwiftUI

class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            DispatchQueue.main.async {
                self.currentHeight = keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        DispatchQueue.main.async {
            self.currentHeight = 0
        }
    }
}

struct HalfModalView<Content: View>: View {
    @StateObject private var keyboard = KeyboardResponder()
    @Environment(\.presentationMode) var presentationMode
    @Binding var isShown: Bool
    @State private var offset: CGFloat = UIScreen.main.bounds.height / 2

    let onDismiss: () -> Void
    let content: Content
    
    init(isShown: Binding<Bool>, onDismiss: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self._isShown = isShown
        self.onDismiss = onDismiss
        self.content = content()
    }

    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        let minHeight: CGFloat = screenSize.height * (keyboard.currentHeight > 0 ? 0.05 : 0.16)

        return VStack {
                ZStack {
                    content
                        .padding(.bottom, max(offset, 0))
                        .animation(.easeOut(duration: 0.2), value: keyboard.currentHeight)
                        .frame(width: screenSize.width * 0.92, height: screenSize.width * 1.23)
                        .background(
                            RoundedRectangle(cornerRadius: 40)
                                .fill(Color.white)
                        )
                        .gesture(
                            DragGesture().onChanged { value in
                                let yOffset = value.translation.height
                                if yOffset > 0 {
                                    offset = yOffset
                                }
                            }
                            .onEnded { value in
                                let threshold = minHeight * 0.2
                                if value.translation.height > threshold {
                                    withAnimation(.easeOut(duration: 0.1)) {
                                        offset = UIScreen.main.bounds.height
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        isShown = false
                                        onDismiss()
                                    }
                                } else {
                                    withAnimation(.easeOut(duration: 0.1)) {
                                        offset = 0
                                    }
                                }
                            }
                        )
                        .onAppear {
                            withAnimation(.easeOut(duration: 0.2)) {
                                offset = 0
                            }
                        }
                        .onDisappear {
                            offset = UIScreen.main.bounds.height / 2
                        }
                }
                .clipped()

        }
        .offset(y: max(minHeight + offset, minHeight))
        .frame(width: screenSize.width, height: screenSize.height)
        .edgesIgnoringSafeArea(.all)
        .background(isShown ? Color.black.opacity(0.3) : Color.clear)
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: offset)
    }
}
