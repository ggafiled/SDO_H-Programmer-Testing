
# SDO Programmer Testing

1. จงเขียน code โดยใช้ For loop หรือ While loop เพื่อให้แสดงผลตามรูปแบบด้านล่างให้เป็นรูปต้นส้น (10 คะแนน)

```c#
using System;
using System.IO;
					
public class Program
{
	public static void Main()
	{
		int tree_layer = Convert.ToInt32(Console.ReadLine());
		int asterix_size = 1;
		int space = tree_layer;
		int tmp_asterix_size = 1;
		int tmp_space = space;
		
		for(int i = 0; i < tree_layer; i++){
		   
		    int represent = ((i+1)%10);
		    		
			for(int j = 0; j < space; j++)
			Console.Write(" ");
			for(int j = 0; j < asterix_size; j++)
			Console.Write(String.Format("{0} ", represent.ToString()));
			
            space--;
			asterix_size++;
			
			Console.WriteLine();
		}
	}
}
```
#### ตัวอย่าง Output:

```text
Compilation succeeded - 2 warning(s)
          1 
         2 2 
        3 3 3 
       4 4 4 4 
      5 5 5 5 5 
     6 6 6 6 6 6 
    7 7 7 7 7 7 7 
   8 8 8 8 8 8 8 8 
  9 9 9 9 9 9 9 9 9 
 0 0 0 0 0 0 0 0 0 0 
```
2. บริษัทแห่งหนึ่งให้พนักงานรูดบัตรเวลาเข้าและออกงาน ซึ่งข้อมูลรหัสพนักงาน (EmployeeID) และเวลารูดบัตร (Clock) จะถูกบันทึกอยู่ในตาราง CardScan และพนักงานแต่ละคนจะมีตารางเวลาการทำงาน (ตาราง WorkSchedule) ซึ่งเก็บรหัสพนักงาน (EmployeeID)  
วันทำงาน (WorkDate) เวลาเริ่มต้นทำงาน (BeginTime) และเวลาสิ้นสุดทำงาน (EndTime) บริษัทตกลงกับพนักงานว่าในแต่ละวัน บริษัทจะพิจารณาข้อมูลรูดบัตรในช่วงเวลา [BeginTime – 5 ชม., EndTime + 5 ชม.] โดยใช้เวลารูดบัตรครั้งแรกในช่วงเวลาดังกล่าวเป็นเวลาเข้างาน (ClockIn) และเวลารูดบัตรครั้งสุดท้ายในช่วงเวลาดังกล่าวเป็นเวลาเลิกงาน (ClockOut)
จงเขียน SQL Statement เพื่อ query ข้อมูลจากตาราง CardScan และ WorkSchedule เพื่อแสดงผล ClockIn, ClockOut ของพนักงานแต่ละคน ในแต่ละวัน (10 คะแนน)

ตัวอย่างข้อมูลในตาราง CardScan เป็นดังนี้

|EmployeeID |Clock|
|-----|---|
|000000001|01/01/2012 07:00:00|
|000000001|01/01/2012 12:00:00|
|000000001|01/01/2012 17:30:00|
|000000002|01/01/2012 08:40:00|
|000000002|01/01/2012 21:00:00|

ตัวอย่างข้อมูลในตาราง WorkSchedule เป็นดังนี้

|EmployeeID|WorkDate|BeginTime|EndTime|
|----|----|-----|----|
|000000001|01/01/2012|01/01/2012 08:00:00|01/01/2012 17:00:00|
|000000001|02/01/2012|02/01/2012 08:00:00|02/01/2012 17:00:00|
|000000002|01/01/2012|01/01/2012 10:00:00|01/01/2012 20:00:00|
|000000002|02/01/2012|02/01/2012 10:00:00|02/01/2012 20:00:00|

ผลลัพธ์ที่ต้องการคือ

|EmployeeID|WorkDate|ClockIn|ClockOut|
|-----|------|-----|-----|
|000000001|01/01/2012|01/01/2012 07:00:00|01/01/2012 17:30:00|
|000000002|01/01/2012|01/01/2012 08:40:00|01/01/2012 21:00:00|

#### คำตอบ

```sql
USE SDO_Employee;

SELECT 
wsd.EmployeeID, 
wsd.WorkDate,
cki.CheckIn,
cko.CheckOut

FROM [WorkSchedule] AS wsd WITH (NOLOCK)

LEFT JOIN (SELECT c.EmployeeID, MIN(c.Clock) AS CheckIn FROM CardScan c WITH (NOLOCK) GROUP BY c.EmployeeID) AS cki ON wsd.EmployeeID = cki.EmployeeID 
AND CONVERT(date, cki.CheckIn) = CONVERT(date, wsd.WorkDate) AND cki.CheckIn BETWEEN DATEADD(hour, -5, wsd.BeginTime) AND DATEADD(hour, 5, wsd.EndTime)

LEFT JOIN (SELECT c.EmployeeID, MAX(c.Clock) AS CheckOut FROM CardScan c WITH (NOLOCK) GROUP BY c.EmployeeID) AS cko ON wsd.EmployeeID = cko.EmployeeID 
AND CONVERT(date, cko.CheckOut) = CONVERT(date, wsd.WorkDate) AND cko.CheckOut BETWEEN DATEADD(hour, -5, wsd.BeginTime) AND DATEADD(hour, 5, wsd.EndTime)

WHERE cki.CheckIn IS NOT NULL
GROUP BY wsd.EmployeeID, wsd.WorkDate, cki.CheckIn, cko.CheckOut

```