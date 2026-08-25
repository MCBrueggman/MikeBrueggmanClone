SOLID Principles Exercise
=========================

1.  Identify every SOLID principle violated in this class. For each violation: name the principle, cite the specific code, explain what harm it causes.

2.  The fetchTimesheets method is untestable. Explain exactly why using the DI principle, and describe what a unit test for this method would require if you cannot inject a dependency.

3.  If the company switches from email to Slack notifications, enumerate every change required in this codebase. Which principle does this touch?

4.	Design a refactored version using protocols/interfaces. Produce: a list of all classes and protocols with a one-sentence description of each, a description of what each class depends on (its constructor parameters), and one code example of how the TimesheetApprovalCoordinator would look.

5.	(Challenge) Write one unit test for the refactored approveTimesheet that uses mock dependencies to verify that the notification is sent when a timesheet is approved.

