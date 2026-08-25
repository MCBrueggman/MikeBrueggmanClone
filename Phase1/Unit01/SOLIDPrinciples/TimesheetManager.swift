class TimesheetManager {
 
    func fetchTimesheets(employeeId: String) -> [Timesheet] {
        let url = "https://api.internalapp.company.com/timesheets/\(employeeId)"
        let data = URLSession.shared.dataTask(url: url)
        return parseJSON(data)
    }
 
    func approveTimesheet(timesheet: Timesheet) {
        timesheet.status = "approved"
        let emailBody = "Your timesheet for week \(timesheet.weekOf) has been approved."
        sendEmail(to: timesheet.employee.email, body: emailBody)
        writeToAuditLog("Timesheet \(timesheet.id) approved at \(Date())")
    }
 
    func exportToCSV(timesheets: [Timesheet]) -> String {
        var csv = "EmployeeID,Week,Hours,Status\n"
        for t in timesheets {
            csv += "\(t.employeeId),\(t.weekOf),\(t.totalHours),\(t.status)\n"
        }
        return csv
    }
 
    func sendEmail(to address: String, body: String) {
        SMTPClient.send(to: address, body: body)
    }
 
    func writeToAuditLog(_ message: String) {
        FileManager.default.appendToLog(message)
    }
}
