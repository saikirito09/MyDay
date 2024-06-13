//
//  CustomTabBar.swift
//  myday
//
//  Created by Sai Mandava on 12/06/24.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    @Binding var showBottomSheet: Bool

    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                selectedTab = 0
            }) {
                Image(systemName: "house")
                    .font(.system(size: 24))
                    .foregroundColor(selectedTab == 0 ? .black : .gray)
            }
            Spacer()
            Button(action: {
                showBottomSheet.toggle()
            }) {
                Image(systemName: "plus.circle")
                    .font(.system(size: 36)) // 1.5 times bigger
                    .foregroundColor(.gray)
            }
            Spacer()
            Button(action: {
                selectedTab = 2
            }) {
                Image(systemName: "person")
                    .font(.system(size: 24))
                    .foregroundColor(selectedTab == 2 ? .black : .gray)
            }
            Spacer()
        }
        .padding()
    }
}
