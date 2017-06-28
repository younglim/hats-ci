# Set path to hats
$path_to_hats = "$env:APPDATA\hats"

echo "Set path to JDK for this session"
$env:Path = "$env:Path;$path_to_hats\jre\bin";

echo "Set path to browser drivers for this session"
$env:Path = "$env:Path;$path_to_hats\drivers";

echo "Activate robot virtual environment"
& "$path_to_hats\robot\Scripts\activate"

cd testpage
.\test.cmd

	