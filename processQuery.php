<?php
	$queryval=filter_input(INPUT_POST, 'queryval');
	$nedInput=filter_input(INPUT_POST, 'nedInput');
	require 'database.php';
	
	if($queryval == 1){
		$query= $db->query("select hallNumber, staffNum, fName, lName, hallName, phoneNumber 
		from Staff inner join ResidenceHall on Staff.staffNum=ResidenceHall.manager;");
		echo "<table border='1'>";
		echo "<tr><td>HallNumber</td><td>Manager</td><td>FirstName</td><td>LastName</td><td>HallName</td><td>PhoneNumber</td></tr>";
		while($row = $query->fetch())
		echo "<tr><td>{$row['hallNumber']}</td><td>{$row['staffNum']}</td><td>{$row['fName']}</td><td>{$row['lName']}</td><td>{$row['hallName']}</td><td>{$row['phoneNumber']}</td></tr>";
		echo "</table>";
	}
	if($queryval == 2){
		$query = $db->query("select leaseNum, leasePeriod, occupantLeave, placeNum, student.muId, fName, lName 
		from lease 
		inner join student 
		on lease.muId=student.muid;");
		echo "<table border='1'>";
		echo "<tr><td>leaseNum</td><td>leasePeriod</td><td>occupantLeave</td><td>placeNum</td><td>muId</td><td>fName</td><td>lName</td></tr>";
		while($row = $query->fetch())
		echo "<tr><td>{$row['leaseNum']}</td><td>{$row['leasePeriod']}</td><td>{$row['occupantLeave']}</td><td>{$row['placeNum']}</td>
		<td>{$row['muId']}</td><td>{$row['fName']}</td><td>{$row['lName']}</td><tr>";
		echo "</table>";
	}
	if($queryval == 3){
		$query= $db->query("Select * from Lease where leasePeriod='Summer';");
		echo "<table border='1'>";
		echo "<tr><td>leaseNum</td><td>leasePeriod</td><td>occupantLeave</td><td>placeNum</td><td>muId</td></tr>";
		while($row = $query->fetch())
		echo "<tr><td>{$row['leaseNum']}</td><td>{$row['leasePeriod']}</td><td>{$row['occupantLeave']}</td><td>{$row['placeNum']}</td>
		<td>{$row['muId']}</td></tr>";
		echo "</table>";
		
	}
	if($queryval == 4){
		$query= $db->query("Select lease.leaseNum, lease.muid, lease.placeNum, student.fName, student.lName, Sum(room.rentRate) as totalPay 
							from lease inner join Student on lease.muid = student.muid inner join room 
							on lease.placeNum = room.placeNum GROUp BY lease.muid;");
		echo "<table border='1'>";
		echo "<tr><td>LeaseNumber</td><td>MUID</td><td>PlaceNumber</td><td>FirstName</td><td>LastName</td><td>TotalPay</td></tr>";
		while($row = $query->fetch())
		echo "<tr><td>{$row['leaseNum']}</td><td>{$row['muid']}</td><td>{$row['placeNum']}</td><td>{$row['fName']}</td><td>{$row['lName']}</td><td>{$row['totalPay']}</td></tr>";
		echo "</table>";
	}
	if($queryval == 5){
		$query= $db->query("select fName, lName, Student.muId From Student inner join Lease on Student.muId=Lease.muId inner join Invoices 
							on Lease.leaseNum=Invoices.leaseNum where TimeStampDiff(day, payDate, '$nedInput')>0;");
		echo "<table border='1'>";
		echo "<tr><td>FirstName</td><td>LastName</td><td>MUID</td></tr>";
		while($row = $query->fetch())
		echo "<tr><td>{$row['fName']}</td><td>{$row['lName']}</td><td>{$row['muId']}</td></tr>";
		echo "</table>";
	}
	if($queryval == 6){
		$query= $db->query("select * from inspections where conditionOfFlat='unsatisfactory';");
		echo "<table border='1'>";
		echo "<tr><td>InspectionNumber</td><td>InspectionDate</td><td>FlatNumber</td><td>InspectorNumber</td><td>Conditions</td><td>Comments</td></tr>";
		while($row = $query->fetch())
		echo "<tr><td>{$row['inspectNum']}</td><td>{$row['inspectDate']}</td><td>{$row['flatNum']}</td><td>{$row['staffNum']}</td><td>{$row['conditionOfFlat']}</td><td>{$row['comments']}</td></tr>";
		echo "</table>";
	}
	if($queryval == 7){
		$query=$db->query("Select fName, lName, Student.muId, Room.roomNum, Room.placeNum 
					from Room Inner Join Lease on Room.placeNum=Lease.placeNum 
					inner Join Student on Student.muId=Lease.muId 
					where hallNum=$nedInput and Lease.placeNum is not null;");
		echo "<table border='1'>";
		echo "<tr><td>FirstName</td><td>LastName</td><td>MUID</td><td>RoomNumber</td><td>PlaceNumber</td></tr>";
		while($row = $query->fetch())
		echo "<tr><td>{$row['fName']}</td><td>{$row['lName']}</td><td>{$row['muId']}</td><td>{$row['roomNum']}</td><td>{$row['placeNum']}</td></tr>";
		echo "</table>";
	}
	if($queryval == 8){
		$query= $db->query("select Student.muId,fName,lName from Student left join Lease on Student.muId=Lease.muId where leaseNum is NULL;");
		echo "<table border='1'>";
		echo "<tr><td>MUID</td><td>FirstName</td><td>LastName</td></tr>";
		while($row = $query->fetch())
		echo "<tr><td>{$row['muId']}</td><td>{$row['fName']}</td><td>{$row['lName']}</td></tr>";
		echo "</table>";
	}
	if($queryval == 9){
		$query= $db->query("select schoolRank, Count(*) as studentCount from Student Group By schoolRank;");
		echo "<table border='1'>";
		echo "<tr><td>SchoolRank</td><td>StudentCount</td></tr>";
		while($row = $query->fetch())
		echo "<tr><td>{$row['schoolRank']}</td><td>{$row['studentCount']}</td></tr>";
		echo "</table>";
	}
	if($queryval == 10){
		$query= $db->query("select fName, lName, muId From Student left join StudentNextOfKin 
							on Student.muId=StudentNextOfKin.StudentMuId where kinId is null;");
		echo "<table border='1'>";
		echo "<tr><td>FirstName</td><td>LastName</td><td>MUID</td></tr>";
		while($row = $query->fetch())
		echo "<tr><td>{$row['fName']}</td><td>{$row['lName']}</td><td>{$row['muId']}</td></tr>";
		echo "</table>";
	}
	if($queryval == 11){
		$query=$db->query("select Advisor.fName, Advisor.lName, internalPhone from Advisor Inner join Student on Advisor.advisorNum=Student.advisorNum where Student.muId=$nedInput");
		echo "<table border='1'>";
		echo "<tr><td>FirstName</td><td>LastName</td><td>InternalPhone</td></tr>";
		while($row = $query->fetch())
		echo "<tr><td>{$row['fName']}</td><td>{$row['lName']}</td><td>{$row['internalPhone']}</td></tr>";
		echo "</table>";
	}
	if($queryval == 12){
		$query= $db-> query("select Min(rentRate) as minimumRate, Max(rentRate) as maximumRate, AVG(rentRate) as averageRate from Room where hallNum is not null;");
		echo "<table border='1'>";
		echo "<tr><td>MinimumRate</td><td>MaximumRate</td><td>AverageRate</td></tr>";
		while($row = $query->fetch())
		echo "<tr><td>{$row['minimumRate']}</td><td>{$row['maximumRate']}</td><td>{$row['averageRate']}</td></tr>";
		echo "</table>";
	}
	if($queryval == 13){
		$query= $db->query("select hallNum, Count(placeNum) as roomCount from Room where hallNum is not null group by hallNum;");
		echo "<table border='1'>";
		echo "<tr><td>HallNumber</td><td>RoomCount</td></tr>";
		while($row = $query->fetch())
		echo "<tr><td>{$row['hallNum']}</td><td>{$row['roomCount']}</td></tr>";
		echo "</table>";
	}
	if($queryval == 14){
		$query= $db->query("select fName, lName, dateOfBirth, TimeStampDiff(YEAR, dateOfBirth, curdate()) as age, street, city, postCode 
							from staff where TimeStampDiff(YEAR, dateOfBirth, curdate()) > 60;");
		echo "<table border='1'>";
		echo "<tr><td>FirstName</td><td>LastName</td><td>DateOfBirth</td><td>Age</td><td>Street</td><td>City</td><td>PostCode</td></tr>";
		while($row = $query->fetch())
		echo "<tr><td>{$row['fName']}</td><td>{$row['lName']}</td><td>{$row['dateOfBirth']}</td><td>{$row['age']}</td><td>{$row['street']}</td><td>{$row['city']}</td><td>{$row['postCode']}</td></tr>";
		echo "</table>";
	}
	if($queryval == 15){
		$query= $db->query("select Count(*) as total 
		from Vehicle Where lotNum=$nedInput;");
		echo "<table border='1'>";
		echo "<tr><td>NumberOfVehicles</td></tr>";
		while($row = $query->fetch())
		echo "<tr><td>{$row['total']}</td></tr>";
		echo "</table>";
	}
?>