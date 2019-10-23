# PowerShell Script to Remove Everything in filename except SxxExx.extention Format then create appropriate folders and move files into them!
# Author: Ashkan Rafiee

function withoutspace {
    Get-ChildItem | Rename-Item -NewName {($_.BaseName -replace '^.*(S\d{2}E\d{2}).*$','$1') + $_.Extension}
}

function withspace {
    Get-ChildItem | Rename-Item -NewName {($_.BaseName -replace '^.*(S\d{2} E\d{2}).*$','$1' -replace ' ','') + $_.Extension}
}

function withdot {
    Get-ChildItem | Rename-Item -NewName {($_.BaseName -replace '^.*(S\d{2}.E\d{2}).*$','$1' -replace '\.','') + $_.Extension}
}

#######Deprecated#######
# function createfolder {
#     cmd /c "for %i in (*) do md "%~ni""
# }
#
# function movefiles {
#    cmd /c "for %i in (*) do move "%i" "%~ni""
# }
#######Deprecated#######

function createfolder {
    foreach ($name in (Get-ChildItem -File | % {$_.BaseName -replace 'E\d{2}',''}))
    {
     if ($name -like 'S*') {
         New-Item -path "$name" -ItemType Directory
         }
    }
}

function movefiles {
    $files = Get-ChildItem -File
    $dir = Get-ChildItem -Directory
    foreach ($item in $files) {
     foreach ($folder in $dir)
     {
         if (($item.Name).Substring(0,3) -like $folder.Name)
         {
                Move-Item -Path $item.FullName -Destination $folder.FullName
         }
        }
    }
}

$User = Read-Host -Prompt 'Are You Sure?(y/n):'

if($User -eq "y") {
    withoutspace
    withspace
    withdot
    createfolder
    movefiles
    echo DONE!
}elseif($User -eq "n") {
    echo Operation Canceled!
}else {
    echo Illegal Option!
}
