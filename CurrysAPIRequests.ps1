$ProductList = Get-Content $PSScriptRoot\ProductID.csv

$Results = Foreach ($productid in $ProductList){

    $Webrequest = Invoke-WebRequest -uri https://api.currys.co.uk/store/api/products/$productid
    $InnerHTML = $WebRequest.ParsedHtml.body.OuterText | ConvertFrom-Json
        

                        [PSCustomObject] @{
                                           ProductID       = $productid
                                           ProductName     = $InnerHTML.payload.Label
                                           ProductLink     = $InnerHTML.payload.Link
                                           ProductPrice    = ($InnerHTML.payload.price.amount) /100
                                           Category        = (($InnerHTML.payload.categorisation).segmentid)
                                           HomeDelivery    = (($InnerHTML.payload.deliveryoptions | ?{$_.id -eq 1}).enabled)
                                                     }

                            }

$Results | ft -AutoSize