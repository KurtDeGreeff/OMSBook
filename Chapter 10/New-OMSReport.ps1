# Sample script from OMS book, Chapter 11
param (
        [Parameter(Mandatory=$true)]
        [String] 
        $Query,
		
		[Parameter(Mandatory=$true)]
        [int] 
        $MaxNumberOfResults,
		
		[Parameter(Mandatory=$true)]
        [int] 
        $RangeHours
        
    )
	  
	  # Get OMS Connection
	  $OMSConn = Get-AutomationConnection -Name 'OMSConnection'
	  
	  # Get Token 
	  $Token = Get-AADToken -OMSConnection $OMSConn
	  
	  # Convert time 
	  $StartTime = (((get-date)).AddHours(-$RangeHours).ToUniversalTime()).ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
  	  $EndTime = ((get-date).ToUniversalTime()).ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
	  
	  # Execute Query 
	  $QueryResult = Invoke-OMSSearchQuery `
                        -SubscriptionID $OMSConn.SubscriptionID `
                        -ResourceGroupName $OMSConn.ResourceGroupName `
                        -OMSWorkspaceName $OMSConn.WorkspaceName `
                        -Query $Query `
						-Start $StartTime `
						-End $EndTime `
						-Top $MaxNumberOfResults `
                        -Token $Token
		
        # Total Records Count
        $TotalRecords = "Total records found: " + $QueryResult.Count + "`n"
        Write-Output $TotalRecords

		# Convert results to readable format 
		$collectionWithItems = @()
        $QueryResult.GetEnumerator() | ForEach-Object {
            $temp = New-Object -TypeName System.Object
            $_.GetEnumerator() | ForEach-Object {
            
            	If ($_.Key.ToString() -ne '__metadata')
            	{
                	$temp | Add-Member -MemberType NoteProperty `
                                       -Name $_.Key.ToString() `
                                       -Value $_.Value.ToString()
            	}

            }
            $collectionWithItems += $temp
        }
		$collectionWithItems | Format-Table


