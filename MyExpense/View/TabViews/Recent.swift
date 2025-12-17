//
//  Recent.swift
//  MyExpense
//
//  Created by Iqbal Alhadad on 15/12/25.
//

import SwiftUI
import SwiftData
import Combine

struct Recent: View {
    
    //user properties
    @AppStorage("username") private var username: String = ""
    @State  var startDate: Date = .now.startofMonth
    @State  var endDate: Date = .now.endofMonth
    @State   var showFilterView: Bool = false
    @State private var selectedCategory: Category = .expense
    //for animation
    @Namespace private var animation
   // @Query(sort: [SortDescriptor(\Transaction.dateAdded, order: .reverse)], animation: .snappy) private var transactions: [Transaction]
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            NavigationStack {
                ScrollView(.vertical) {
                    LazyVStack(spacing:10,pinnedViews: [.sectionHeaders]){
                        Section {
                           // date filter
                            Button(action:{
            showFilterView = true
                            }, label : {
                                Text("\(format(date: startDate,format: "dd - MMM yy"))to\(format(date:endDate,format: "dd - MMM yy"))")
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                            })
                            .hSpacing(.leading)
                            
                            FilterTransactionView(startDate: startDate, endDate: endDate) {
                                transactions in
                                CardView(income: total(transactions, category: .income)
                                         , expense: total(transactions, category: .expense))
                                
                                //CUSTOM SEGEMENTED CONTROL
                            CustomSegmentedControl()
                                    .padding(.bottom, 10)
                                ForEach(transactions.filter({
                                    $0.category == selectedCategory.rawValue
                                })) { transaction in
                                    NavigationLink {
                                        TransactionView(editTransaction: transaction)
                                    } label : {
                                        TransactionCardView(transaction: transaction)
                                    }
                                   
                                    .buttonStyle(.plain)
                                   
                                }
                            }
                            
                            //card view
                           
//                            ForEach(sampleTransactions.filter({
//                                $0.category == selectedCategory.rawValue
//                            })){
//                                transaction in
//                                TransactionCardView(transaction: transaction)
//                            }
                        } header: {
                            HeaderView(size)
                        }
                        
                    }
                    .padding(15)
                }
                .background(.gray.opacity(0.15))
                .blur(radius: showFilterView ? 8 : 0)
                .disabled(showFilterView)
            }
            .overlay {
                    if showFilterView {
                       DateFilterView(start: startDate, end: endDate, onSubmit: { start, end in
                           startDate = start
                           endDate = end
                          showFilterView = false
                      }, onClose: {
                          showFilterView = false
                      })
                       .transition(.move(edge: .leading))
                   }
               
            }
            .animation(.snappy, value: showFilterView)
           
        }
    }


    //header view
    @ViewBuilder
    func HeaderView(_ size:CGSize) -> some View {
        HStack(spacing: 10){
            VStack(alignment: .leading, spacing: 5, content: {
                Text("Welcome")
                    .font(.title.bold())
                
                if !username.isEmpty {
                    Text(username)
                        .font(.callout)
                        .foregroundStyle(Color.gray)
                }
            })
            
            .visualEffect {
                content, geometryProxy in
                content
                    .scaleEffect(headerScale(size, proxy: geometryProxy), anchor: .topLeading)
            }
           
            Spacer(minLength: 0)
          
                NavigationLink {
                    TransactionView()
                } label: {
                    Image(systemName: "plus")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 45, height: 45)
                        .background(appTint.gradient, in: .circle)
                        .contentShape(.circle)
                }
            }
        .padding(.bottom, username.isEmpty ? 10 : 5)
        .background{
            VStack(spacing: 0) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                
                Divider()
            }
            .visualEffect {
                content, geometryProxy in
                content
                    .opacity(headerBGOpacity(geometryProxy))
            }
                .padding(.horizontal, -15)
                .padding(.top, -(safeArea.top + 15))
        }
    }
    
    //segmented control
    @ViewBuilder
    func CustomSegmentedControl() -> some View {
        HStack(spacing: 0) {
            ForEach(Category.allCases, id: \.rawValue){
                category in
                Text(category.rawValue)
                    .hSpacing()
                    .padding(.vertical, 10)
                    .background {
                        if category == selectedCategory {
                            Capsule()
                                .fill(.background)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .contentShape(.capsule)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedCategory = category
                        }
                    }
            }
        }
        .background(.gray.opacity(0.15), in: .capsule)
    }

    
    func headerBGOpacity(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY + safeArea.top
        return minY > 0 ? 0 : (-minY / 15)
    }
    
    func headerScale(_ size: CGSize, proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY
        let screenHeight = size.height
        
        let progress = minY / screenHeight
        let scale = (min(max(progress,0),1)) * 0.4
        
        return 1 + scale
    }
    
    
    
    
}

// Inline date range filter view used by Recent overlay
//struct DateRangeFilterView: View {
//    var start: Date
//    var end: Date
//    var onSubmit: (_ start: Date, _ end: Date) -> Void
//    var onClose: () -> Void
//
//    @State private var tempStart: Date
//    @State private var tempEnd: Date
//
//    init(start: Date, end: Date, onSubmit: @escaping (_ start: Date, _ end: Date) -> Void, onClose: @escaping () -> Void) {
//        self.start = start
//        self.end = end
//        self.onSubmit = onSubmit
//        self.onClose = onClose
//        _tempStart = State(initialValue: start)
//        _tempEnd = State(initialValue: end)
//    }
//
//    var body: some View {
//        ZStack {
//            Color.black.opacity(0.3)
//                .ignoresSafeArea()
//                .onTapGesture { onClose() }
//
//            VStack(spacing: 16) {
//                HStack {
//                    Text("Filter by Date")
//                        .font(.headline)
//                    Spacer()
//                    Button(action: { onClose() }) {
//                        Image(systemName: "xmark.circle.fill")
//                            .font(.title3)
//                            .foregroundStyle(.secondary)
//                    }
//                }
//
//                VStack(alignment: .leading, spacing: 12) {
//                    Text("Start Date")
//                        .font(.caption)
//                        .foregroundStyle(.secondary)
//                    DatePicker("", selection: $tempStart, displayedComponents: .date)
//                        .datePickerStyle(.graphical)
//                        .labelsHidden()
//
//                    Text("End Date")
//                        .font(.caption)
//                        .foregroundStyle(.secondary)
//                    DatePicker("", selection: $tempEnd, in: tempStart...Date.distantFuture, displayedComponents: .date)
//                        .datePickerStyle(.graphical)
//                        .labelsHidden()
//                }
//
//                Button {
//                    onSubmit(tempStart, tempEnd)
//                } label: {
//                    Text("Apply")
//                        .fontWeight(.semibold)
//                        .frame(maxWidth: .infinity)
//                        .padding(.vertical, 12)
//                        .background(appTint, in: .capsule)
//                        .foregroundStyle(.white)
//                }
//            }
//            .padding(16)
//            .background(.background, in: .rect(cornerRadius: 16))
//            .padding(.horizontal, 24)
//        }
//    }
//}

#Preview {
    ContentView()
}
