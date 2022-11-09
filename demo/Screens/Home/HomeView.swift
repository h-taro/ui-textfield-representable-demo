//
//  HomeView.swift
//  demo
//
//  Created by 平石　太郎 on 2022/11/10.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel = .init()
    
    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Rectangle()
                .fill(Color.blue.opacity(0.8))
                .frame(width: 200, height: 400, alignment: .center)
            
            TestTextField(text: $viewModel.text1, keyboardType: .default)
                .darkTextFieldStyle()
            
            Spacer()
            
            TestTextField(text: $viewModel.text2, keyboardType: .default)
                .darkTextFieldStyle()
            
            Spacer()
            
            TestTextField(text: $viewModel.text3, keyboardType: .default)
                .darkTextFieldStyle()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
