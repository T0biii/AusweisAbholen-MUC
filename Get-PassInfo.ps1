param(
    $passNummer = ""
)


Write-Verbose "Passnummer: $passNummer"
Write-Verbose "Do WebRquest for cookie"
$cookie = Invoke-WebRequest -Uri "https://www17.muenchen.de/Passverfolgung/" -Headers @{
    "sec-ch-ua"="`" Not;A Brand`";v=`"99`", `"Microsoft Edge`";v=`"91`", `"Chromium`";v=`"91`""
    "sec-ch-ua-mobile"="?0"
      "Upgrade-Insecure-Requests"="1"
      "User-Agent"="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36 Edg/91.0.864.67"
      "Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"
      "Sec-Fetch-Site"="none"
      "Sec-Fetch-Mode"="navigate"
      "Sec-Fetch-User"="?1"
      "Sec-Fetch-Dest"="document"
      "Accept-Encoding"="gzip, deflate, br"
      "Accept-Language"="de-DE,de;q=0.9,en-US;q=0.8,en;q=0.7"
    };
Write-Verbose $cookie
$cookieToken = $cookie.Headers.'Set-Cookie'.split(";")[0]
Write-Verbose "CookieToken: $cookieToken"
Write-Verbose "Sleep 3 Sec."
Start-Sleep -Seconds 3
Write-Verbose "Do WebRquest for PassInfo"
$passOnline = Invoke-WebRequest -Uri "https://www17.muenchen.de/Passverfolgung/" -Method "POST" -Headers @{
"Cache-Control"="max-age=0"
  "sec-ch-ua"="`" Not;A Brand`";v=`"99`", `"Microsoft Edge`";v=`"91`", `"Chromium`";v=`"91`""
  "sec-ch-ua-mobile"="?0"
  "Origin"="https://www17.muenchen.de"
  "Upgrade-Insecure-Requests"="1"
  "DNT"="1"
  "User-Agent"="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36 Edg/91.0.864.67"
  "Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"
  "Sec-Fetch-Site"="same-origin"
  "Sec-Fetch-Mode"="navigate"
  "Sec-Fetch-User"="?1"
  "Sec-Fetch-Dest"="document"
  "Referer"="https://www17.muenchen.de/Passverfolgung/"
  "Accept-Encoding"="gzip, deflate, br"
  "Accept-Language"="de,de-DE;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6"
  "Cookie"="JSESSIONID=$cookieToken"
} -ContentType "application/x-www-form-urlencoded" -Body "ifNummer=$passNummer&pbAbfragen=Abfragen&__ncforminfo=$($cookie.InputFields.value)" -UseBasicParsing
Write-Verbose $passOnline
$pass = ConvertFrom-Html -Content $passOnline.Content
Write-Verbose $pass
$passInfo = $pass.SelectNodes('/html/body/table/tr/td/table/tr[9]/td')
Write-Verbose $passInfo
if($passInfo.innerText.Contains("Abholung")){
    if($passInfo.InnerText.Contains("nicht")){
        Write-host $passInfo.InnerText -ForegroundColor RED -BackgroundColor Black
    }else{
        $PassType = $pass.SelectNodes('/html/body/table/tr/td/table/tr[6]/td').InnerText
        $passlocationName = ($pass.SelectNodes('/html/body/table/tr/td/table/tr[12]/td/table/tr[2]/td[2]/table/tr/td').ChildNodes[0].InnerText).Trim()
        $passlocationStreet = ($pass.SelectNodes('/html/body/table/tr/td/table/tr[12]/td/table/tr[2]/td[2]/table/tr/td').ChildNodes[2].InnerText).Trim()
        $output = "$PassType $($passInfo.InnerText) $passlocationName $passlocationStreet"
        Write-host $output -ForegroundColor Green -BackgroundColor Black
    }
}else {
    $passInfo = $pass.SelectNodes('/html/body/table/tr/td/table/tr[4]/td/font')
    Write-Verbose $passInfo
    Write-Host $passInfo.InnerText -ForegroundColor RED -BackgroundColor Black
}
