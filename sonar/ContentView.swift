//
//  ContentView.swift
//  sonar
//
//  Created by MacBook Pro M1 on 2022/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        if #available(iOS 16.0, *) {
            NavigationStack {
                SonarView()
                    .navigationTitle("Sonar")
            }
            
        } else {
            // Fallback on earlier versions
            NavigationView {
                SonarView()
                    .navigationTitle("Sonar")
            }
            .navigationViewStyle(.stack)
            
        }
    }
}

struct SonarView: View {
    @ObservedObject var pingObserver = PingObserver()
    @State var isStarted = false
    @State var destination = "8.8.8.8"
    
    var body: some View {
        List {
            Section("Destination") {
                TextField("", text: $destination)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(false)
                    .keyboardType(.URL)
                    .padding(.horizontal, 5)
            }
            
            Section("Response") {
                Text(pingObserver.responses)
                    .padding(.horizontal, 5)
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar, content: {
                Button {
                    isStarted.toggle()
                    
                    if isStarted {
                        pingObserver.start(destination: destination)
                    } else {
                        pingObserver.stop()
                    }
                } label: {
                    if isStarted {
                        Image(systemName: "stop.fill")
                    } else {
                        Image(systemName: "play.fill")
                    }
                }
                
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
