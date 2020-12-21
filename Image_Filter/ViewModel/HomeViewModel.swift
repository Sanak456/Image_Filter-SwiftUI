//
//  HomeViewModel.swift
//  Image_Filter
//
//  Created by Sanak Ghosh on 10/1/20.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

class HomeViewModel : ObservableObject {
    
    @Published var imagePicker = false
    @Published var imageData = Data(count: 0)
    
    @Published var allImage: [FilteredImage] = []
    
    // Maiin Editing Image...
    @Published var mainView: FilteredImage! // Customizing Filter
    
    // Slider for Intensity And Redius etc...
    // Since We didn't set while reading image
    // so all will be full value...
    @Published var value : CGFloat = 1.0 // line 74
    
    // Loading FilterOption WhenEver Image is Selected...
    
    // Use Your Own Filters...
    
    let filters: [CIFilter] = [  // Applying filter to image
    
        CIFilter.sepiaTone(),CIFilter.comicEffect(),CIFilter.colorInvert(),CIFilter.photoEffectFade(),CIFilter.colorMonochrome(),CIFilter.photoEffectChrome(),CIFilter.gaussianBlur(),CIFilter.bloom()
    
    ]
    
    func loadFilter() {
        
        let context = CIContext()
        
        filters.forEach { (filter) in
            
            // To avoid lag do it in background
            
            DispatchQueue.global(qos: .userInteractive).async {
                
                // loading image into filter..
                let CiImage = CIImage(data: self.imageData)
                
                filter.setValue(CiImage!, forKey: kCIInputImageKey)
                
                // retreving image..
                
                guard let newImage = filter.outputImage else{return}
                
                // creating UIImage...
                
                let cgimage = context.createCGImage(newImage, from: newImage.extent)
                
                let isEditable = filter.inputKeys.count > 1
                
                let filteredData = FilteredImage(image: UIImage(cgImage: cgimage!), filter: filter, varisEditable: isEditable)
                
                DispatchQueue.main.async {
                    
                    self.allImage.append(filteredData)
                    
                    // default is First Filter...
                    
                    if self.mainView == nil{ // line 20
                        
                        self.mainView = self.allImage.first
                    }
                }
            }
            
        }
        
    }
    
    func updateEffect() {
        
        let context = CIContext()
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            // loading image into filter..
            let CiImage = CIImage(data: self.imageData)
            
            let filter = self.mainView.filter
            
            filter.setValue(CiImage!, forKey: kCIInputImageKey)
            
            // retreving image...
            
            // there are lot of custom options are available
            // I'm only using redius and intensity...
            // use your own based on your usage...
            
            // radius you can give up to 100
            // I'm using only 30
            
            if filter.inputKeys.contains("inputRadius"){
                
                filter.setValue(self.value * 10, forKey: kCIInputRadiusKey)
            }
            if filter.inputKeys.contains("inputIntensity") {
                
                filter.setValue(self.value, forKey: kCIInputIntensityKey)
            }
            
            guard let newImage = filter.outputImage else{return}
            
            // creating UIImage...
            
            let cgimage = context.createCGImage(newImage, from: newImage.extent)
            
            DispatchQueue.main.async {
                
                // Updating View...
                
                self.mainView.image = UIImage(cgImage: cgimage!)
            }
        }
    }
}
