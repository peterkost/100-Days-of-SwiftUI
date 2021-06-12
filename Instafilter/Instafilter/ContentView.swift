//
//  ContentView.swift
//  Instafilter
//
//  Created by Peter Kostin on 2021-06-12.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    
    @State private var showIntensitySlider = true
    @State private var showRadiusSlider = false
    @State private var showScaleSlider = false
    
    @State private var showingSaveError = false
    @State private var showingFilterSheet = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State var currentFilterString = "Sepia Tone"
    @State var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                filterIntensity
            },
            set: {
                filterIntensity = $0
                applyProcessing()
            }
        )
        
        let radius = Binding<Double>(
            get: {
                filterRadius
            },
            set: {
                filterRadius = $0
                applyProcessing()
            }
        )
        
        let scale = Binding<Double>(
            get: {
                filterScale
            },
            set: {
                filterScale = $0
                applyProcessing()
            }
        )
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil{
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                if showIntensitySlider {
                    HStack {
                        Text("Intensity")
                        Slider(value: intensity)
                    }.padding(.vertical)
                }

                if showRadiusSlider {
                    HStack {
                        Text("Radius")
                        Slider(value: radius)
                    }.padding(.vertical)
                }

                if showScaleSlider {
                    HStack {
                        Text("Scale")
                        Slider(value: scale)
                    }.padding(.vertical)
                }


                HStack {
                    Button(currentFilterString) {
                        showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        guard image != nil else {
                            showingSaveError = true
                            return
                        }
                        
                        guard let processedImage = self.processedImage else { return }
                        
                        let imageSaver = ImageSaver()
                        
                        imageSaver.successHandler = {
                            print("Success!")
                        }

                        imageSaver.errorHandler = {
                            print("Oops: \($0.localizedDescription)")
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) { setFilter(CIFilter.crystallize())
                        currentFilterString = "Crystallize" },
                    .default(Text("Edges")) { setFilter(CIFilter.edges())
                        currentFilterString = "Edges" },
                    .default(Text("Gaussian Blur")) { setFilter(CIFilter.gaussianBlur())
                        currentFilterString = "Gaussian Blur" },
                    .default(Text("Pixellate")) { setFilter(CIFilter.pixellate())
                        currentFilterString = "Pixellate" },
                    .default(Text("Sepia Tone")) { setFilter(CIFilter.sepiaTone())
                        currentFilterString = "Sepia Tone" },
                    .default(Text("Unsharp Mask")) { setFilter(CIFilter.unsharpMask())
                        currentFilterString = "Unsharp Mask" },
                    .default(Text("Vignette")) { setFilter(CIFilter.vignette())
                        currentFilterString = "Vignette" },
                    .cancel()
                ])
            }
            .alert(isPresented: $showingSaveError) {
                Alert(title: Text("Save Error"), message: Text("You haven't selected an image."), dismissButton: .default(Text("Ok")))
            }

            
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
            showIntensitySlider = true
        } else { showIntensitySlider = false }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
            showRadiusSlider = true
        } else { showRadiusSlider = false }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey)
            showScaleSlider = true
        } else { showScaleSlider = false }

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
        
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
