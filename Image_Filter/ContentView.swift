//
//  ContentView.swift
//  Image_Filter
//
//  Created by Sanak Ghosh on 10/1/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView{
            
            Home()
            // darkMode...
                .navigationBarTitle("Filter")
                .preferredColorScheme(.dark)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
