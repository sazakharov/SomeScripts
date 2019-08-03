# Hide Current Script Window

$Signature = @'
[DllImport("user32.dll")]public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
'@

$ShowWindowAsync = Add-Type -MemberDefinition $Signature -Name "Win32ShowWindowAsync" -Namespace Win32Functions -PassThru 
$ShowWindowAsync::ShowWindowAsync((Get-Process -Id $pid).MainWindowHandle, 0)
