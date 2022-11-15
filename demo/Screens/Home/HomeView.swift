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
                emailTextField
                
                PasswordTextField(
                    password: $viewModel.password,
                    placeholder: "パスワードを入力してください"
                )
                
                HogeTextField(hoge: $viewModel.hoge)
                
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
    
    private var emailTextField: some View {
        VStack(alignment: .leading, spacing: 8) {
            EmailTextField(
                text: $viewModel.email,
                placeholder: "mail@example.com",
                emailValidSubject: viewModel.emailValidSubject
            )
            
            if viewModel.isShowErrorView {
                HStack(alignment: .center, spacing: 4) {
                    Image(systemName: "exclamationmark.circle")
                    
                    Text("エラーメッセージエラーメッセージエラーメッセージ")
                        .font(.caption)
                        .fontWeight(.regular)
                }
                .foregroundColor(.red.opacity(0.8))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
