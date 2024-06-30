import SwiftUI
import SwiftData
import Charts

struct StepChart: View {
    var steps: [StepData]
    
    var body: some View {
        Chart {
            ForEach(steps){step in
                RuleMark(y: .value("Goal", 10000))
                
                BarMark(
                    x: .value("Date", getBarString(step.date)),
                    y: .value("Steps", step.steps)
                )
                .annotation(position: .top,
                            spacing: 12) {
                        Text("\(step.steps)")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(getBarColor(steps: step.steps, threshold: 10000))
                    
                            
                }
                .annotation(position: .bottomLeading,
                            spacing: -2) {
                    Text("\(round(step.distance))")
                        .font(.caption)
                        .bold()
                }
                    
                .clipShape(.rect(
                topLeadingRadius: 15,
                topTrailingRadius: 15
                ))
                .foregroundStyle(getBarColor(steps: step.steps, threshold: 10000))
            }
        }
        .chartYAxis(.hidden)
        .chartXAxis {
            AxisMarks(position: .bottom) { _ in
                // AxisGridLine().foregroundStyle(.clear)
                // AxisTick().foregroundStyle(.clear)
                AxisValueLabel()
            }
        }
        .chartScrollableAxes(.horizontal)
        .frame(height: 500)
        .defaultScrollAnchor(.trailing)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)


    return StepChart(steps: generateFakeStepData(days: 10)).modelContainer(container)
}

