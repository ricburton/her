//
//  VoiceSettingsView.swift
//  Her
//
//  Created by Steven Sarmiento on 4/4/24.
//

import SwiftUI

struct VoiceSettingsView: View {
    @Binding var activeModal: MainView.ActiveModal?
    @Binding var selectedOption: Option?
    @ObservedObject var callManager: CallManager
    @ObservedObject var keyboardResponder: KeyboardResponder
    @State private var currentStep: Int = 1

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    ZStack {
                        HStack {
                            Image(systemName: "waveform")
                                .resizable()
                                .foregroundColor(.black.opacity(0.05))
                                .frame(width: 85, height: 85)
                            Spacer()
                        }
                        .offset(x: 10, y: -20)

                    
                        VStack(alignment: .leading) {
                            Text("Who do you want to talk to?")
                                .font(.system(size: 20, design: .rounded))
                                .bold()
                                .foregroundColor(Color.black.opacity(1))
                                .padding(.bottom, 2)
                            Text("Choose a preset prompt or create your own custom Ai to converse with.")
                                .font(.system(size: 14))
                                .foregroundColor(Color.black.opacity(0.5))

                        }
                        .padding(.horizontal, 20)
                        .offset(x: UIScreen.isLargeDevice ? 0 : -12)
                    }
                }
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.black.opacity(0.1)),
                    alignment: .bottom
                )
            }
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.black.opacity(0.05))
                    .frame(maxWidth: .infinity)
                    .frame(height: 140),
                     alignment: .bottom
                )
            .overlay(
                XMarkButton {
                        if currentStep == 2 {
                            withAnimation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0)) {
                                currentStep = 1
                            }
                        } else {
                           withAnimation(.easeOut(duration: 0.15)) {
                                self.activeModal = nil
                           }
                        }
                }
                .offset(x: -20, y: 0),
                alignment: .topTrailing
            )

            if currentStep == 1 {
                CustomTextPromptView(selectedOption: $selectedOption, callManager: callManager, keyboardResponder: keyboardResponder) {
                    withAnimation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0)) {
                        currentStep = 2
                    }
                }
            } else if currentStep == 2 {
                VoiceTypeAndToneView(activeModal: $activeModal, selectedOption: $selectedOption, callManager: callManager, keyboardResponder: keyboardResponder) {
                    withAnimation(.easeOut(duration: 0.15)) {
                        activeModal = nil
                    }
                }
            }
        }
        .padding(.vertical)  
        }
}
