//
//  ContentView.swift
//  MyNotes
//
//  Created by Mariam Mchedlidze on 08.12.23.
//

import SwiftUI

struct TaskInfo: Identifiable {
    var id = UUID()
    var color: Any
    var taskName: String
    var date: String
    var completed: Bool

}

struct ContentView: View {
    
    // MARK: - UI Colors
    
    let backgroundColor = Color(red: 2/255, green: 2/255, blue: 6/255, opacity: 1)
    let cardBackgroundColor = Color(red: 24/255, green: 24/255, blue: 24/255, opacity: 1)
    let primeTextColor = Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 1)
    let secondaryTextColor = Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 0.8)
    let buttonColor = Color(red: 186/255, green: 131/255, blue: 222/255, opacity: 1)
    let circleColor = Color(red: 255/255, green: 118/255, blue: 59/255, opacity: 1)
    let noteTabColor = Color(red: 250/255, green: 203/255, blue: 186/255, opacity: 1)
    let noteTabColor2 = Color(red: 215/255, green: 240/255, blue: 255/255, opacity: 1)
    let noteTabColor3 = Color(red: 250/255, green: 217/255, blue: 255/255, opacity: 1)
    
    // MARK: - Task Cases
    
    @State private var task = [
        TaskInfo(color: "noteTabColor", taskName: "Mobile App Research", date: "4 Oct", completed: true),
        TaskInfo(color: "noteTabColor2", taskName: "Prepare Wireframe for Main Flow", date: "4 Oct", completed: true),
        TaskInfo(color: "noteTabColor3", taskName: "Prepare Screens", date: "4 Oct", completed: true),
        TaskInfo(color: "noteTabColor", taskName: "Mobile App Research", date: "4 Oct", completed: false),
        TaskInfo(color: "noteTabColor2", taskName: "Prepare Wireframe for Main Flow", date: "4 Oct", completed: false),
        TaskInfo(color: "noteTabColor3", taskName: "Prepare Screens", date: "4 Oct", completed: false)
    ]
    
    // MARK: - Convert Color Func
    
    func colorForName(_ name: String) -> Color {
        switch name {
        case "noteTabColor":
            return noteTabColor
        case "noteTabColor2":
            return noteTabColor2
        case "noteTabColor3":
            return noteTabColor3
        default:
            return cardBackgroundColor
        }
    }
    
    //MARK: - Tasks Count
    
    var remainingTasks: Int {
        return task.filter { !$0.completed }.count
    }
    var completedTasks: Int {
        return task.filter({ $0.completed }).count
    }
    var totalTasks: Int {
        return task.count
    }
    
    var sortedTasks: [TaskInfo] {
            task.sorted { $0.completed && !$1.completed }
        }

    
    // MARK: - UI VIEW
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack(alignment: .leading){
                
                HStack{
                    Text("You have \(remainingTasks) tasks to complete")
                        .foregroundColor(primeTextColor)
                        .font(.system(size: 25, weight: .semibold))
                        .lineLimit(2)
                    
                    Spacer()
                    
                    Image("user")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .fill(circleColor)
                                .frame(width: 20, height: 20)
                                .overlay(
                                    Text("\(remainingTasks)")
                                        .foregroundColor(primeTextColor)
                                        .font(.system(size: 12, weight: .regular))
                                )
                                .offset(x: 18, y: 25)
                        )
                }
                
                Button("Complete All") {
                    task.indices.forEach { index in
                        task[index].completed = true
                    }
                }
                
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(buttonColor)
                .foregroundColor(primeTextColor)
                .cornerRadius(8)
                .padding(.top, 24)
                
                Text("Progress")
                    .foregroundColor(primeTextColor)
                    .font(.system(size: 22))
                    .padding(.top, 20)
                
                // MARK: - Daily Task Card
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(cardBackgroundColor)
                        .frame(height: 108)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Daily Task")
                            .foregroundColor(primeTextColor)
                            .font(.system(size: 18, weight: .medium))
                        Text("\(completedTasks)/\(totalTasks) Task Completed")
                            .foregroundColor(secondaryTextColor)
                            .font(.system(size: 16, weight: .regular))
                        Text("Keep Working")
                            .foregroundColor(secondaryTextColor)
                            .font(.system(size: 14, weight: .ultraLight))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                }
                
                // MARK: - Completed Task Cards
                
                Text("Completed Tasks")
                    .foregroundColor(primeTextColor)
                    .font(.system(size: 22))
                    .padding(.top, 24)
                
                ScrollView(.vertical) {
                    ForEach($task) { $task in
                        ZStack {
                            Rectangle()
                                .fill(cardBackgroundColor)
                                .frame(height: 80)
                            
                            HStack{
                                Rectangle()
                                    .fill(colorForName(task.color as! String))
                                    .frame(width:15, height:80)
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(task.taskName)
                                        .foregroundColor(primeTextColor)
                                        .font(.system(size: 16, weight: .regular))
                                    HStack{
                                        Image(systemName: "calendar")
                                            .foregroundColor(secondaryTextColor)
                                        Text(task.date)
                                            .foregroundColor(secondaryTextColor)
                                            .font(.system(size: 14, weight: .medium))
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(8)
                                
                                Button(action: {
                                    task.completed.toggle()
                                }) {
                                    Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(buttonColor)
                                        .imageScale(.large)
                                }
                                .padding(16)
                            }
                        }
                        .cornerRadius(8)
                    }
                }
            }
            .padding(24)
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
