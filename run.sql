SELECT 
wsd.EmployeeID, 
wsd.WorkDate,
cki.CheckIn,
cko.CheckOut

FROM WorkSchedule AS wsd
LEFT JOIN CardScan AS csn ON wsd.EmployeeID = csn.EmployeeID
LEFT JOIN (SELECT c.EmployeeID, MIN(c.Clock) AS CheckIn FROM CardScan c GROUP BY c.EmployeeID) AS cki 
ON wsd.EmployeeID = cki.EmployeeID
LEFT JOIN (SELECT c.EmployeeID, MAX(c.Clock) AS CheckOut FROM CardScan c GROUP BY c.EmployeeID) AS cko 
ON wsd.EmployeeID = cko.EmployeeID 

GROUP BY wsd.EmployeeID, wsd.WorkDate