<main>
	<h1> MU Database </h1>
	<form action="processQuery.php" method="post" id="MU_View_Form" >
	<?php $queryval="";$nedInput="";?>
	<label><b>Select which list you want to view.</b></label><br>
	<select name="queryval" id="queryval">
		<option value="1"  <?PHP if($queryval==1) echo "selected";?>>Manager Name and Phone Number for Each Hall</option>
		<option value="2"  <?PHP if($queryval==2) echo "selected";?>>Name and MU Number of Students with Lease Details</option>
		<option value="3"  <?PHP if($queryval==3) echo "selected";?>>Lease Details that Involve Summer Semester</option>
		<option value="4"  <?PHP if($queryval==4) echo "selected";?>>Total Rent Paid by a Given Student</option>
		<option value="5"  <?PHP if($queryval==5) echo "selected";?>>Students Who Have not Paid Their Invoice by Given Date</option>
		<option value="6"  <?PHP if($queryval==6) echo "selected";?>>Details of Inspections that Were Unsatisfactory</option>
		<option value="7"  <?PHP if($queryval==7) echo "selected";?>>Present a List of Name and Sudent MU Numbers with Room and Place Number in a Specific Residence Hall </option>
		<option value="8"  <?PHP if($queryval==8) echo "selected";?>>Present Students Currently on Waiting List for Accomodations</option>
		<option value="9"  <?PHP if($queryval==9) echo "selected";?>>Display Total Number of Students in Each Student Category</option>
		<option value="10"  <?PHP if($queryval==10) echo "selected";?>>Present the Names and MU numbers for All Students Who Have No Next of Kin</option>
		<option value="11"  <?PHP if($queryval==11) echo "selected";?>>Display the Name and Phone Number of the Advisor of a Particular Student</option>
		<option value="12"  <?PHP if($queryval==12) echo "selected";?>>Display the Minimum, Maximum, and Average Monthly Rent for Rooms in Residence Halls</option>
		<option value="13"  <?PHP if($queryval==13) echo "selected";?>>Display Total Number of Places in Each Residence Hall</option>
		<option value="14"  <?PHP if($queryval==14) echo "selected";?>>Display the Staff Number, Name, Age, and Current Location of All 60 Year Old Staff</option>
		<option value="15"  <?PHP if($queryval==15) echo "selected";?>>Display the Total Number of Registered Vehicles in a Particular Parking Lot</option>
	</select><br>
	<h2> Input Needed Value </h2>
	<input type="text" name="nedInput" value="" /><br><br>
	<input type="submit" value="Engage" /><br>
</main>