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
            VStack(alignment: .leading, spacing: 16) {
                EmailTextField(
                    text: $viewModel.email,
                    placeholder: "mail@example.com"
                )
                
                PasswordTextField(
                    password: $viewModel.password,
                    placeholder: "パスワードを入力してください"
                )
                
                Button(action: viewModel.onTapDone) {
                    Text("DONE")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.blue.opacity(0.8))
                        )
                }
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
