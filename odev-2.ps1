$Processes = @{}
Get-Process -IncludeUserName | ForEach-Object {
    $Processes[$_.Id] = $_
}


# TCP Querysi oluşturduk inşallah
echo "TCP Daemons"
Get-NetTCPConnection | 
    Where-Object { $_.LocalAddress.Split(":")[-1] } |
    Select-Object LocalAddress,
        LocalPort,
        @{Name="ProcessName"; Expression={ $Processes[[int]$_.OwningProcess].ProcessName }} |
    Sort-Object -Property LocalPort, UserName |
    Format-Table -AutoSize | Out-File -FilePath C:\Users\LENOVO\Desktop\tcp.txt

   
    Get-Content -Path C:\Users\LENOVO\Desktop\tcp.txt


# Burada da UDP Querysi oluşturduk inşallah
echo "UDP Daemons"
Get-NetUDPEndpoint | 
    Where-Object { $_.LocalAddress.Split(":")[-1] } |
    Select-Object LocalAddress,
        LocalPort, 
        @{Name="ProcessName"; Expression={ $Processes[[int]$_.OwningProcess].ProcessName }} |
    Sort-Object -Property LocalPort, UserName |
    Format-Table -AutoSize |  Out-File -FilePath C:\Users\LENOVO\Desktop\udp.txt

   
    Get-Content -Path C:\Users\LENOVO\Desktop\udp.txt


#Out-File C:\Users\LENOVO\Desktop\abc.txt -Encoding utf8
#PS> Get-Content -Path C:\Users\LENOVO\Desktop\abc.txt