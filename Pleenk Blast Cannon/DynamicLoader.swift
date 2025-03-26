import Foundation


import SwiftUI


struct DynamicLoader: View {
    var progress: Double
    @State private var rotationAngle: Double = 0
    var body: some View {
        GeometryReader { geometry in
            ZStack {
               
               
                VStack {
                    
                    Spacer()
                    Image(.ball2)
                        .resizable()
                        .scaledToFit()
                }
                VStack {
                    
                    
                    HStack {
                        
                        Spacer()
                        Image(.ball1)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width * 0.3)
                           
                    }
                    Spacer()
                    Image(.cannon)
                        .resizable()
                        .scaledToFit()
                       
                }
                
                VStack {
                    Spacer()
                    Image(.bottom)
                        .resizable()
                        .scaledToFit()
                    
                }
                .ignoresSafeArea()
               
                
//                HStack {
//                    Image(.dashes)
//                        .resizable()
//                        .frame(width: 20, height: geometry.size.height)
//                    Spacer()
//                    Image(.dashes)
//                        .resizable()
//                        .frame(width: 20, height: geometry.size.height)
//                }
//                .frame(width: geometry.size.width * 0.4)
                
//                HStack {
//                    VStack {
//                        Image(.z1)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: geometry.size.width * 0.3)
//                        Spacer()
//                            .frame(height: geometry.size.height * 0.3)
//                        
//                        Image(.z2)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: geometry.size.width * 0.3)
//                        
//                    }
//                    
//                    Spacer()
//                        .frame(width: geometry.size.width * 0.4)
//                    
//                    
//                    VStack {
//                        Image(.z2)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: geometry.size.width * 0.3)
//                        Spacer()
//                            .frame(height: geometry.size.height * 0.1)
//                        
//                        Image(.z4)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: geometry.size.width * 0.3)
//                        
//                    }
//                }
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    Image(.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.8)
                    
                    
                    
                    
                   
                    
                    
                   
                    
                    
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    ZStack {
                        
                        
//                        Circle()
//                            .fill(Color.black.opacity(0.3))
//                            .frame(width: 80, height: 80)
//                            .overlay(
//                                Circle()
//                                    .fill(
//                                        RadialGradient(
//                                            gradient: Gradient(colors: [
//                                                Color.red.opacity(0.2),
//                                                Color.black.opacity(0.5)
//                                            ]),
//                                            center: .center,
//                                            startRadius: 0,
//                                            endRadius: 40
//                                        )
//                                    )
//                            )
//                            .blur(radius: 5)

                     
//                            .shadow(color: .green.opacity(0.3), radius: 10, x: 0, y: 0)
//                            .animation(
//                                Animation.easeInOut(duration: 2)
//                                    .repeatForever(autoreverses: false),
//                                value: rotationAngle
//                            )
//                            .onAppear {
//                                rotationAngle = 360
//                            }

                        // Дополнительные "капли крови"
//                        ForEach(0..<3) { i in
//                            Circle()
//                                .fill(Color.red.opacity(0.7))
//                                .frame(width: 8, height: 8)
//                                .offset(x: CGFloat.random(in: -30...30),
//                                       y: CGFloat.random(in: -30...30))
//                                .blur(radius: 2)
//                        }

                        // Текст с эффектом "зомби"
//                        Text("\(Int(progress * 100))%")
//                            .font(.custom("Chalkduster", size: 24))
//                            .fontWeight(.bold)
//                            .foregroundStyle(
//                                LinearGradient(
//                                    colors: [.green.opacity(0.8), .red.opacity(0.7)],
//                                    startPoint: .topLeading,
//                                    endPoint: .bottomTrailing
//                                )
//                            )
//                            .shadow(color: .green.opacity(0.5), radius: 3, x: 2, y: 2)
//                            .overlay(
//                                Text("\(Int(progress * 100))%")
//                                    .font(.custom("Chalkduster", size: 24))
//                                    .fontWeight(.bold)
//                                    .foregroundColor(.black.opacity(0.3))
//                                    .offset(x: 1, y: 1)
//                            )
                    }
                }
                VStack {
                    Circle()
                                    .trim(from: 0.0, to: 0.7)
                                    .stroke(
                                        AngularGradient(
                                            gradient: Gradient(colors: [
                                                Color.green.opacity(0.8),
                                                Color.red.opacity(0.6),
                                                Color.green.opacity(0.4)
                                            ]),
                                            center: .center
                                        ),
                                        style: StrokeStyle(
                                            lineWidth: 6,
                                            lineCap: .round,
                                            dash: [5, 10]
                                        )
                                    )
                                    .frame(width: 60, height: 60)
                                    .rotationEffect(Angle(degrees: rotationAngle))
                                    .onAppear {
                                        withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                                            rotationAngle = 360
                                        }
                                    }
                    Spacer()
                }
            }
            .frame(width: geometry.size.width)
            .background(
                Image(.background)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    DynamicLoader(progress: 0.75)
}
