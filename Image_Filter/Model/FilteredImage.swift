//
//  FilteredImage.swift
//  Image_Filter
//
//  Created by Sanak Ghosh on 10/2/20.
//

import SwiftUI
import CoreImage

struct FilteredImage: Identifiable {
   
    var id = UUID().uuidString
    var image: UIImage
    var filter: CIFilter
    var varisEditable: Bool
}

struct FilteredImage_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
