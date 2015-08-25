<?php
$username = "thoughts_ga6840";
$password = "xxxxxxxxxxxxx";
$hostname = "localhost"; 

//connection to the database
$db = mysql_connect($hostname, $username, $password) 
  or die("Unable to connect to MySQL");

echo "Connected to MySQL<br>";

$result = mysql_query("select * from information_schema.tables ".
                      "group by engine");

while ($row = mysql_fetch_array($result)) {
      echo $row{'TABLE_NAME'}."'s engine is ".$row{'ENGINE'}."<br>";
}

mysql_close($db);
?>
