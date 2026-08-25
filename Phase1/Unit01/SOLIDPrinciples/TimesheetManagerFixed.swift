protocol TimesheetRepository {
    func fetchTimesheets(employeeId: String) -> [Timesheet]
}

protocol NotificationService {
    func sendMessage(to: String, message: String)
}

protocol TimesheetExporter {
    func export(timesheet: Timesheet)
}

protocol AuditLogProtocol {
    func writeToAuditLog(_ message: String)
}

class EmailNotificationService: NotificationService {
    func sendMessage(to address: String, message: String) {
        SMTPClient.send(to: address, body: message)
    }
}

class TimesheetCsvExporter: TimesheetExporter {
    func exportToCSV(timesheets: [Timesheet]) -> String {
        var csv = "EmployeeID,Week,Hours,Status\n"
        for t in timesheets {
            csv += "\(t.employeeId),\(t.weekOf),\(t.totalHours),\(t.status)\n"
        }
        return csv
    }
}



class TimesheetManager {
    private let messageService: NotificationService
    private let auditLog: AuditLogProtocol

    init(messageService: NotificationService, auditLog: AuditLogProtocol) {
        self.messageService = messageService
        self.auditLog = AuditLogProtocol
    }

    func fetchTimesheets(employeeId: String) -> [Timesheet] {
        let url = "https://api.internalapp.company.com/timesheets/\(employeeId)"
        let data = URLSession.shared.dataTask(url: url)
        return parseJSON(data)
    }
 
    func approveTimesheet(timesheet: Timesheet) {
        timesheet.status = "approved"
        let emailBody = "Your timesheet for week \(timesheet.weekOf) has been approved."
        messageService.sendEmail(to: timesheet.employee.email, body: emailBody)
        writeToAuditLog("Timesheet \(timesheet.id) approved at \(Date())")
    }
    
}


class MockMessageService: NotificationService {

}

class MockLogService : AuditLogProtocol {
    methodWasCalled: Bool = false
    messageUsed: String

    func writeToAuditLog(_ message: String) {
        methodWasCalled = true
        messageUsed = message
    }
}

func test() {
    mockMessage = MockMessageService()
    mockLog = MockLogService()

    mgr = TimesheetManager()
    timesheet = Timesheet() // set its properties
    mgr.approveTimesheet(timesheet)

    // assert that no errors were thrown
    // another test would verify that log method was called
    assert(mockLog.methodWasCalled == true)
    
}
