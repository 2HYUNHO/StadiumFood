//
//  DatePickerView.swift
//  StadiumFood
//
//  Created by 이현호 on 8/3/24.
//

import SwiftUI

struct DatePickerView: View {
    @ObservedObject var viewModel: CalendarViewModel
    
    var body: some View {
        HStack {
            Button {
                viewModel.goToPreviousDay()
            } label: {
                Image(systemName: "chevron.left")
            }
            
            HStack {
                ForEach(viewModel.dates) { calendarDate in
                    Button {
                        viewModel.selectDate(calendarDate.date)
                    } label: {
                        Text(viewModel.formatterDate(calendarDate.date))
                            .foregroundStyle(viewModel.isSelectedDate(calendarDate.date) ? .black : .gray)
                            .fontWeight(viewModel.isSelectedDate(calendarDate.date) ? .bold : .regular)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            
            Spacer()
            
            Button {
                viewModel.goToNextDay()
            } label: {
                Image(systemName: "chevron.right")
            }
        }
        .padding()
    }
}
