$Filepath = "\Path\to\some\file"
$MD5 = [Security.Cryptography.HashAlgorithm]::Create( "MD5" )
$stream = ([IO.StreamReader]"$Filepath").BaseStream
$md5hash = -join ($MD5.ComputeHash($stream) | ForEach { "{0:x2}" -f $_ })
$stream.Close()
