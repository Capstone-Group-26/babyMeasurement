//
//  HostingController.swift
//  test2
//
//  Created by Leenknecht, Aaron M on 3/12/20.
//  Copyright © 2020 baby body measurements. All rights reserved.
//

import UIKit
import SwiftUI

class HostingController: UIHostingController<AnyView> {

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: AnyView(EmptyView()))
    }
    
}
