//
//  VCSwiftUIView.swift
//  test2
//
//  Created by Leenknecht, Aaron M on 3/12/20.
//  Copyright © 2020 baby body measurements. All rights reserved.
//

import SwiftUI
import UIKit

struct VCSwiftUIView: UIViewControllerRepresentable {
    let storyboard: String
    let VC: String

  func makeUIViewController(context: UIViewControllerRepresentableContext<VCSwiftUIView>) -> ViewController {
    
    //Load the storyboard
    let loadedStoryboard = UIStoryboard(name: storyboard, bundle: nil)
    
    //Load the ViewController
     return loadedStoryboard.instantiateViewController(withIdentifier: VC) as! ViewController
    
  }
  
  func updateUIViewController(_ uiViewController: ViewController, context: UIViewControllerRepresentableContext<VCSwiftUIView>) {
  }
}
