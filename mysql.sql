CREATE TABLE IF NOT EXISTS CardScan (
    EmployeeID VARCHAR(9) NOT NULL,
    Clock DATETIME Not NULL
)

CREATE TABLE IF NOT EXISTS WorkSchedule (
    EmployeeID VARCHAR(9) NOT NULL,
    WorkDate DATE NOT NULL,
    BeginTime DATETIME NOT NULL,
    EndTime DATETIME NOT NULL
)

INSERT INTO CardScan (EmployeeID, Clock)
VALUES 
('000000001', '	01/01/2012 07:00:00'),
('000000001', '	01/01/2012 12:00:00'),
('000000001', '	01/01/2012 17:30:00'),
('000000002', '	01/01/2012 08:40:00'),
('000000002', '	01/01/2012 21:00:00')

INSERT INTO WorkSchedule (EmployeeID, WorkDate, BeginTime, EndTime)
VALUES 
('000000001', '01/01/2012', '01/01/2012 08:00:00', '01/01/2012 17:00:00'),
('000000001', '02/01/2012', '02/01/2012 08:00:00', '02/01/2012 17:00:00'),
('000000002', '01/01/2012', '01/01/2012 10:00:00', '01/01/2012 20:00:00'),
('000000002', '02/01/2012', '02/01/2012 10:00:00', '02/01/2012 20:00:00')