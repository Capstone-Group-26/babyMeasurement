//
//  LineChart.swift
//  test2
//
//  Created by Leenknecht, Aaron M on 3/12/20.
//  Copyright © 2020 baby body measurements. All rights reserved.
//

import UIKit
import SwiftUI

// 1.
struct LineChart: UIViewControllerRepresentable {

    // 2.
    func makeUIViewController(context: Context) -> UIFontPickerViewController {
        return UIFontPickerViewController()
    }
    
    // 3.
    func updateUIViewController(_ uiViewController: UIFontPickerViewController, context: Context) {
        
    }
}

