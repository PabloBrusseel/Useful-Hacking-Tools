<?php

// This script will delete malicious code from php files within a directory. This can be useful when your files have been injected with malicious code.

// Config
ini_set('max_execution_time', 0);

$target_directory = '\html'; // Directory to start inside of

$virus_begin_signature_str = 'start of signature'; // Start of malicious code
$virus_end_signature_str = 'end of signature'; // End of malicious code
$virus_name = 'Virus Name'; // Make up a name here, just for output pusposes
// End of config

$recursive_directory_iter = new RecursiveDirectoryIterator($target_directory);
$iterator = new RecursiveIteratorIterator($recursive_directory_iter);

$decontaminated_files_count = 0;

foreach ($iterator as $filename => $cur)
{
    $path_info = pathinfo($filename);

    if (!isset($path_info['extension'])) {
        continue;
    }

    if ($path_info['extension'] !== 'php') {
        continue;
    }

    echo "Checking: '".$filename."'"."<br>";

    $contents = file_get_contents($filename);

    $virus_begin_pos = strpos($contents, $virus_begin_signature_str);

    if ($virus_begin_pos !== false && $filename !== __FILE__) {
        echo $virus_name." found in '".$filename."'"."<br>";

        $virus_end_str = $virus_end_signature_str;
        $virus_end_pos = strpos($contents, $virus_end_str) + strlen($virus_end_str);

        $before_virus_content = substr($contents, 0, $virus_begin_pos);
        $after_virus_content = substr($contents, $virus_end_pos);

        echo $virus_name." content between start pos ".$virus_begin_pos." and end pos ".$virus_end_pos." deleted"."<br>";

        $contents = $before_virus_content.$after_virus_content;

        file_put_contents($filename, $contents);

        $decontaminated_files_count++;
    }
}

echo $decontaminated_files_count." files were infected and decontaminated in the directory '".$target_directory."'"."<br>";