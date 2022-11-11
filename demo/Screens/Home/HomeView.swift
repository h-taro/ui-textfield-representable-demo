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
            VStack(alignment: .leading, spacing: .zero) {
                EmailTextField(
                    text: $viewModel.text1,
                    placeholder: "mail@example.com"
                )
            }
            .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
