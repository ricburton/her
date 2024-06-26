//
//  ChangelogView.swift
//  Res
//
//  Created by Steven Sarmiento on 6/9/24.
//

import SwiftUI

struct ChangelogStep: Identifiable {
    let id = UUID()
    let version: String
    let description: String
    let bulletPoints: [String]
    let imageName: String?
    let isLastStep: Bool
}

struct ChangelogView: View {
    var dismissAction: () -> Void

    let steps: [ChangelogStep] = [
        ChangelogStep(version: "1.0.12", description: "RES gets a make over for WWDC24. New Testflight is here!", bulletPoints: ["privacy mode enabled by HIPAA compliance", "Added visualizer for voice activity", "GPT 4o base model", "Performance improvements ;)" ], imageName: "", isLastStep: true),
    ]

    var body: some View {

            ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: [Color(red: 0.047, green: 0.071, blue: 0.071), Color(red: 0.047, green: 0.071, blue: 0.071)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .edgesIgnoringSafeArea(.all)

                VStack {
                Spacer()
                    .frame(height: 60)
                
                HStack {
                    Button(action: {
                        withAnimation(.easeOut(duration: 0.1)) {
                            self.dismissAction()
                        }
                        let impactMed = UIImpactFeedbackGenerator(style: .soft)
                        impactMed.impactOccurred()
                    }) {
                        HStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundColor(.white.opacity(0.3))
                        }
                    }
                    Spacer()
                    
                    Text("Changelog")
                        .bold()
                        .font(.system(size: 20, design: .rounded))
                        .foregroundColor(Color.white.opacity(0.8))
                    
                    
                    Spacer()

                    // Button(action: {
                    //     //action
                    //     let impactMed = UIImpactFeedbackGenerator(style: .soft)
                    //     impactMed.impactOccurred()
                    // }) {
                    //     HStack {
                    //         Image(systemName: "info.circle.fill")
                    //             .font(.system(size: 20))
                    //             .bold()
                    //             .foregroundColor(.white.opacity(0.3))
                    //     }
                    // }
                }
                .padding(.bottom, 20)

                    ZStack {
                        HStack(alignment: .top) {
                            if let appIcon = UIImage(named: "AppIcon") {
                                Image(uiImage: appIcon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(18)
                                    .padding(.bottom, 5)
                                    .shadow(color: Color.black.opacity(0.5), radius: 5)
                            } else {
                                Text("App Icon not found")
                                    .foregroundColor(.white)
                            }

                            VStack(alignment: .leading, spacing: 5) {
                                Text("Explore the latest AI models and have real conversations.")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .foregroundColor(Color.white.opacity(0.5))
                                 Button(action: {
                                    if let url = URL(string: "https://github.com/rescomputer/res-ios") {
                                        UIApplication.shared.open(url)
                                    }
                                    let impactMed = UIImpactFeedbackGenerator(style: .soft)
                                    impactMed.impactOccurred()
                                }) {
                                    Text("RES is open-source")
                                        .font(.system(size: 16, design: .monospaced))
                                        .foregroundColor(.orange.opacity(0.8))    
                                }
                            }.padding(.horizontal)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 90, alignment: .center)

                    ScrollView {
                        changelogContent()
                    }
                    .applyScrollViewEdgeFadeDark()
   

                 Spacer()
                 Spacer()
                 
                }
                .padding()
                .padding(.horizontal, 10)
                .slideDown()

        }
    }
}

extension ChangelogView {

    private func changelogContent() -> some View {
        VStack {
            ForEach(steps) { step in
                timelineStep(version: step.version, description: step.description, bulletPoints: step.bulletPoints, imageName: step.imageName, isLastStep: step.isLastStep)
            }
        }
        .padding(.top, 10)
    }

    private func timelineStep(version: String, description: String, bulletPoints: [String], imageName: String?, isLastStep: Bool = false) -> some View {
        HStack(alignment: .top, spacing: 15) {
            VStack {
                RoundedRectangle(cornerRadius: 13)
                    .frame(width: 43, height: 22)
                    .foregroundColor(Color.white.opacity(0.1))
                    .overlay(
                        Text(version)
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.5))
                    )
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 3, height: isLastStep ? 0 : .infinity)
                    .foregroundColor(Color.white.opacity(0.07))
            }
            .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(Color.white.opacity(0.5))
                
                ForEach(bulletPoints, id: \.self) { bullet in
                    HStack(alignment: .top) {
                        Text("•")
                            .font(.system(size: 14))
                            .foregroundColor(Color.white.opacity(0.5))
                        Text(bullet)
                            .font(.system(size: 14))
                            .foregroundColor(Color.white.opacity(0.5))
                    }
                }
                
                if let imageName = imageName {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                        .padding(.bottom, 20)
                }
            }
        }
    }
}

#Preview {
    ChangelogView(dismissAction: {})
}
