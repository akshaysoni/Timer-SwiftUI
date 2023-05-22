//
//  ContentView.swift
//  Timer
//
//  Created by Akshay Soni on 21/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var appState: AppState
    @State var timer:Timer?
    @StateObject var timerViewModel:TimerViewModel  = TimerViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 15.0)
                    .opacity(0.3)
                    .foregroundColor(Color.orange)
                Circle()
                    .trim(from: 0.0, to: CGFloat(timerViewModel.progress))
                    .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.red)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear, value: 100)
                //                    .animation(Animation.easeInOut, value: 1)
                Text(timerViewModel.time).font(Font.system(size: 65,weight: .heavy))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                //                    .background(.red)
            }.padding(EdgeInsets(top: 30, leading: 30, bottom: 0, trailing: 30))
                .fixedSize(horizontal: false, vertical: true)
            HStack {
                Button( timerViewModel.isRunning ? "Pause":"Start") {
                    !timerViewModel.isRunning ?
                    timerViewModel.startTimer() : timerViewModel.pauseTimer()
                    appState.timerActive = timerViewModel.isRunning
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                Button("Stop") {
                    timerViewModel.stopTimer()
                    appState.timerActive = false
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            //            .background(Color.red)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity,minHeight: 60.0)
            Spacer()
        }
        .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity)
        .frame(alignment: Alignment(horizontal: .center, vertical: .top))
        .onAppear() {
            timerViewModel.setAppState(appState: appState)
        }
        .onReceive(appState.$isActive) { output in
            if output == true {
                timerViewModel.appInForeground()
            }
            else {
                timerViewModel.appInBackground()
            }
        }
//        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
//            debugPrint("willResignActiveNotification")
//        }
//        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
//            debugPrint("didBecomeActiveNotification")
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
