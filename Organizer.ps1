# PowerShell Script to Remove Everything in filename except SxxExx.extention Format then create appropriate folders and move files into them!
# Author: Ashkan Rafiee

function Show-Organizer_psf {

	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Define SAPIEN Types
	#----------------------------------------------
	try{
		[FolderBrowserModernDialog] | Out-Null
	}
	catch
	{
		Add-Type -ReferencedAssemblies ('System.Windows.Forms') -TypeDefinition  @" 
		using System;
		using System.Windows.Forms;
		using System.Reflection;

        namespace SAPIENTypes
        {
		    public class FolderBrowserModernDialog : System.Windows.Forms.CommonDialog
            {
                private System.Windows.Forms.OpenFileDialog fileDialog;
                public FolderBrowserModernDialog()
                {
                    fileDialog = new System.Windows.Forms.OpenFileDialog();
                    fileDialog.Filter = "Folders|\n";
                    fileDialog.AddExtension = false;
                    fileDialog.CheckFileExists = false;
                    fileDialog.DereferenceLinks = true;
                    fileDialog.Multiselect = false;
                    fileDialog.Title = "Select a folder";
                }

                public string Title
                {
                    get { return fileDialog.Title; }
                    set { fileDialog.Title = value; }
                }

                public string InitialDirectory
                {
                    get { return fileDialog.InitialDirectory; }
                    set { fileDialog.InitialDirectory = value; }
                }
                
                public string SelectedPath
                {
                    get { return fileDialog.FileName; }
                    set { fileDialog.FileName = value; }
                }

                object InvokeMethod(Type type, object obj, string method, object[] parameters)
                {
                    MethodInfo methInfo = type.GetMethod(method, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
                    return methInfo.Invoke(obj, parameters);
                }

                bool ShowOriginalBrowserDialog(IntPtr hwndOwner)
                {
                    using(FolderBrowserDialog folderBrowserDialog = new FolderBrowserDialog())
                    {
                        folderBrowserDialog.Description = this.Title;
                        folderBrowserDialog.SelectedPath = !string.IsNullOrEmpty(this.SelectedPath) ? this.SelectedPath : this.InitialDirectory;
                        folderBrowserDialog.ShowNewFolderButton = false;
                        if (folderBrowserDialog.ShowDialog() == DialogResult.OK)
                        {
                            fileDialog.FileName = folderBrowserDialog.SelectedPath;
                            return true;
                        }
                        return false;
                    }
                }

                protected override bool RunDialog(IntPtr hwndOwner)
                {
                    if (Environment.OSVersion.Version.Major >= 6)
                    {      
                        try
                        {
                            bool flag = false;
                            System.Reflection.Assembly assembly = Assembly.Load("System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089");
                            Type typeIFileDialog = assembly.GetType("System.Windows.Forms.FileDialogNative").GetNestedType("IFileDialog", BindingFlags.NonPublic);
                            uint num = 0;
                            object dialog = InvokeMethod(fileDialog.GetType(), fileDialog, "CreateVistaDialog", null);
                            InvokeMethod(fileDialog.GetType(), fileDialog, "OnBeforeVistaDialog", new object[] { dialog });
                            uint options = (uint)InvokeMethod(typeof(System.Windows.Forms.FileDialog), fileDialog, "GetOptions", null) | (uint)0x20;
                            InvokeMethod(typeIFileDialog, dialog, "SetOptions", new object[] { options });
                            Type vistaDialogEventsType = assembly.GetType("System.Windows.Forms.FileDialog").GetNestedType("VistaDialogEvents", BindingFlags.NonPublic);
                            object pfde = Activator.CreateInstance(vistaDialogEventsType, fileDialog);
                            object[] parameters = new object[] { pfde, num };
                            InvokeMethod(typeIFileDialog, dialog, "Advise", parameters);
                            num = (uint)parameters[1];
                            try
                            {
                                int num2 = (int)InvokeMethod(typeIFileDialog, dialog, "Show", new object[] { hwndOwner });
                                flag = 0 == num2;
                            }
                            finally
                            {
                                InvokeMethod(typeIFileDialog, dialog, "Unadvise", new object[] { num });
                                GC.KeepAlive(pfde);
                            }
                            return flag;
                        }
                        catch
                        {
                            return ShowOriginalBrowserDialog(hwndOwner);
                        }
                    }
                    else
                        return ShowOriginalBrowserDialog(hwndOwner);
                }

                public override void Reset()
                {
                    fileDialog.Reset();
                }
            }
       }
"@ -IgnoreWarnings | Out-Null
	}
	#endregion Define SAPIEN Types

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$formSeriesOrganizer = New-Object 'System.Windows.Forms.Form'
	$labelEnterYourSeriesNameB = New-Object 'System.Windows.Forms.Label'
	$buttonSearchIMDB = New-Object 'System.Windows.Forms.Button'
	$SeriesName = New-Object 'System.Windows.Forms.TextBox'
	$label2 = New-Object 'System.Windows.Forms.Label'
	$label1 = New-Object 'System.Windows.Forms.Label'
	$labelOptional = New-Object 'System.Windows.Forms.Label'
	$buttonCapitalizeFiles = New-Object 'System.Windows.Forms.Button'
	$buttonCreateSeriesFolderAn = New-Object 'System.Windows.Forms.Button'
	$buttonCapitalizeFolders = New-Object 'System.Windows.Forms.Button'
	$buttonBrowseFolder = New-Object 'System.Windows.Forms.Button'
	$textboxFolder = New-Object 'System.Windows.Forms.TextBox'
	$button2 = New-Object 'System.Windows.Forms.Button'
	$labelThird = New-Object 'System.Windows.Forms.Label'
	$labelSecond = New-Object 'System.Windows.Forms.Label'
	$labelFirst = New-Object 'System.Windows.Forms.Label'
	$labelMadeByAshkanRafiee = New-Object 'System.Windows.Forms.Label'
	$labelOrganizeYourSeriesAu = New-Object 'System.Windows.Forms.Label'
	$Move_Files = New-Object 'System.Windows.Forms.Button'
	$Create_Folders = New-Object 'System.Windows.Forms.Button'
	$Rename = New-Object 'System.Windows.Forms.Button'
	$buttonWebsite = New-Object 'System.Windows.Forms.Button'
	$button1 = New-Object 'System.Windows.Forms.Button'
	$folderbrowsermoderndialog1 = New-Object 'SAPIENTypes.FolderBrowserModernDialog'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	$Rename_Click={
		#Rename Series Files to SxxExx Format
		if ($folderbrowsermoderndialog1.SelectedPath -eq "")
		{
			$textboxFolder.Text = "You Have to Choose Your Path First!!!"
			return $Error
		}
		else
		{
			Get-ChildItem | Rename-Item -NewName { ($_.BaseName -replace '^.*(S\d{2}E\d{2}).*$', '$1') + $_.Extension }
			Get-ChildItem | Rename-Item -NewName { ($_.BaseName -replace '^.*(S\d{2} E\d{2}).*$', '$1' -replace ' ', '') + $_.Extension }
			Get-ChildItem | Rename-Item -NewName { ($_.BaseName -replace '^.*(S\d{2}.E\d{2}).*$', '$1' -replace '\.', '') + $_.Extension }
			Get-ChildItem | Rename-Item -NewName { ($_.BaseName -replace '^.*(S\d{2}-E\d{2}).*$', '$1' -replace '-', '') + $_.Extension }
		}
	}
	
	$Create_Folders_Click={
		#Creates Folders Appropriate to Seasons Names
		if ($folderbrowsermoderndialog1.SelectedPath -eq "")
		{
			$textboxFolder.Text = "You Have to Choose Your Path First!!!"
			return $Error
		}
		else
		{
			foreach ($name in (Get-ChildItem -File | % { $_.BaseName -replace 'E\d{2}', '' }))
			{
				if ($name -like 'S*')
				{
					New-Item -Path "$name" -ItemType Directory
				}
			}
		}	
	}
		
	$Move_Files_Click={
		#Moves Files To Appropriate Folders
		if ($folderbrowsermoderndialog1.SelectedPath -eq "")
		{
			$textboxFolder.Text = "You Have to Choose Your Path First!!!"
			return $Error
		}
		else
		{
			$files = Get-ChildItem -File
			$dir = Get-ChildItem -Directory
			foreach ($item in $files)
			{
				foreach ($folder in $dir)
				{
					if (($item.Name).Substring(0, 3) -like $folder.Name)
					{
						Move-Item -Path $item.FullName -Destination $folder.FullName
					}
				}
			}
		}
	}
		
	$buttonBrowseFolder_Click3 = {
		#Browse Desired Location to Work
		if($folderbrowsermoderndialog1.ShowDialog() -eq 'OK')
		{
			$textboxFolder.Text = $folderbrowsermoderndialog1.SelectedPath
			Set-Location -Path $folderbrowsermoderndialog1.SelectedPath
		}
	}
	
	$buttonCapitalizeFolders_Click = {
		if ($folderbrowsermoderndialog1.SelectedPath -eq "")
		{
			$textboxFolder.Text = "You Have to Choose Your Path First!!!"
			return $Error
		}
		else
		{
			#Capitalize Folders
			
			#My Old Tricks before directory switch
			#Get-ChildItem -Exclude *.* | Rename-Item -NewName { ($_.BaseName.ToUpper()) }
			
			#Powershell Can't uppercase folder names so i use cmd tricks
			#Get-ChildItem -Directory | Rename-Item -NewName { $_.name.toupper() }
			Get-ChildItem -Directory | foreach { cmd /c ren $_.fullname $_.name.toupper() }
		}
	}
	
	$buttonCapitalizeFiles_Click = {
		if ($folderbrowsermoderndialog1.SelectedPath -eq "")
		{
			$textboxFolder.Text = "You Have to Choose Your Path First!!!"
			return $Error
		}
		else
		{
			#Capitalize Files
			Get-ChildItem | Rename-Item -NewName { ($_.BaseName.ToUpper() + $_.Extension) }
		}
	}
	
	$buttonCreateSeriesFolderAn_Click = {
		if ($folderbrowsermoderndialog1.SelectedPath -eq "")
		{
			$textboxFolder.Text = "You Have to Choose Your Path First!!!"
			return $Error
		}
		else
		{
			if ($SeriesName.Text -eq "")
			{
				$wshell = New-Object -ComObject Wscript.Shell
				$wshell.Popup("You have to enter your Series Name!", 0, "Error!", 0x0)
			}
			else
			{
				#Moves Everything to a Folder
				$everything = Get-ChildItem
				New-Item -Path $SeriesName.Text -ItemType Directory
				foreach ($thing in $everything)
				{
					Move-Item -Path $thing.FullName -Destination $SeriesName.Text
				}
			}
		}
	}
	
	$labelMadeByAshkanRafiee_Click={
		#Opens a Url To my Website
		Start-Process "https:/AshkanRafiee.ir/main"
	}
		
	$button2_Click = {
		#Opens a Url to SeriesOrganizer Website
		Start-Process "https:/AshkanRafiee.ir/SeriesOrganizer"
	}
	
	$buttonSearchIMDB_Click = {
		if ($SeriesName.Text -eq "")
		{
			$wshell = New-Object -ComObject Wscript.Shell
			$wshell.Popup("You have to enter your Series Name!", 0, "Error!", 0x0)
		}
		else
		{
			#Search IMDB For Desired String
			$query = $SeriesName.Text -replace " ","+"
			Start-Process "https://www.imdb.com/find?q=$query"
		}
		
	}
	
	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$formSeriesOrganizer.WindowState = $InitialFormWindowState
	}
	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$buttonSearchIMDB.remove_Click($buttonSearchIMDB_Click)
			$buttonCapitalizeFiles.remove_Click($buttonCapitalizeFiles_Click)
			$buttonCreateSeriesFolderAn.remove_Click($buttonCreateSeriesFolderAn_Click)
			$buttonCapitalizeFolders.remove_Click($buttonCapitalizeFolders_Click)
			$buttonBrowseFolder.remove_Click($buttonBrowseFolder_Click3)
			$button2.remove_Click($button2_Click)
			$labelMadeByAshkanRafiee.remove_Click($labelMadeByAshkanRafiee_Click)
			$Move_Files.remove_Click($Move_Files_Click)
			$Create_Folders.remove_Click($Create_Folders_Click)
			$Rename.remove_Click($Rename_Click)
			$formSeriesOrganizer.remove_Load($Form_StateCorrection_Load)
			$formSeriesOrganizer.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$formSeriesOrganizer.SuspendLayout()
	#
	# formSeriesOrganizer
	#
	$formSeriesOrganizer.Controls.Add($labelEnterYourSeriesNameB)
	$formSeriesOrganizer.Controls.Add($buttonSearchIMDB)
	$formSeriesOrganizer.Controls.Add($SeriesName)
	$formSeriesOrganizer.Controls.Add($label2)
	$formSeriesOrganizer.Controls.Add($label1)
	$formSeriesOrganizer.Controls.Add($labelOptional)
	$formSeriesOrganizer.Controls.Add($buttonCapitalizeFiles)
	$formSeriesOrganizer.Controls.Add($buttonCreateSeriesFolderAn)
	$formSeriesOrganizer.Controls.Add($buttonCapitalizeFolders)
	$formSeriesOrganizer.Controls.Add($buttonBrowseFolder)
	$formSeriesOrganizer.Controls.Add($textboxFolder)
	$formSeriesOrganizer.Controls.Add($button2)
	$formSeriesOrganizer.Controls.Add($labelThird)
	$formSeriesOrganizer.Controls.Add($labelSecond)
	$formSeriesOrganizer.Controls.Add($labelFirst)
	$formSeriesOrganizer.Controls.Add($labelMadeByAshkanRafiee)
	$formSeriesOrganizer.Controls.Add($labelOrganizeYourSeriesAu)
	$formSeriesOrganizer.Controls.Add($Move_Files)
	$formSeriesOrganizer.Controls.Add($Create_Folders)
	$formSeriesOrganizer.Controls.Add($Rename)
	$formSeriesOrganizer.AccessibleDescription = 'Organize Your Series Automatically'
	$formSeriesOrganizer.AccessibleName = 'Series Organizer'
	$formSeriesOrganizer.AutoScaleDimensions = '6, 13'
	$formSeriesOrganizer.AutoScaleMode = 'Font'
	$formSeriesOrganizer.BackColor = 'PeachPuff'
	$formSeriesOrganizer.ClientSize = '668, 322'
	$formSeriesOrganizer.FormBorderStyle = 'Fixed3D'
	#region Binary Data
	$formSeriesOrganizer.Icon = [System.Convert]::FromBase64String('
AAABAAUAEBAAAAEAIABoBAAAVgAAABgYAAABACAAiAkAAL4EAAAgIAAAAQAgAKgQAABGDgAAMDAA
AAEAIACoJQAA7h4AAAAAAAABACAAgUcAAJZEAAAoAAAAEAAAACAAAAABACAAAAAAAAAEAAAAAAAA
AAAAAAAAAAAAAAAAQEREA0NGRwNdXGMAXFthAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAUlNXAFNUWABCRkYDQEREA0hLTQIxNzQULjQwWS40MGYuNDBlLjQwZS40MGUuNDBlLjQwZS41
MGUuNTFlLzUxZS81MWYvNTBZMTc0FEhLTQIAEAYALzg1Z0BpfvxJgqT/SICi/0iAov9IgKP/SICi
/0h/of9GfJ7/RXib/0R3m/9FeZz/PWJ5/C84NWcACAAAXAMAATI+PoxQlb//Xbr1/1y48/9ct/D/
WbDm/1mu5P9ZruT/Wa7l/1mw6/9Wqeb/VKbk/0mHs/8xPT2MYRsAAS0ZBgU0RUmlU57M/1y38f9c
uPL/UprF/z1ebf9AaHz/QGh8/z1ebf9Smsb/W7bw/1es6P9Mjr//M0NHpTAgDAUqHxANN05VvFan
2f9ct/H/XLjy/1CWv/9IfZz/Wa7j/1mu4/9IfZz/UJa//1y48v9btvD/Up3Q/zVKUrwrIxMNKSMX
GTpXZNFZr+X/XLjy/1y38f9btOz/WrLp/1y48v9cuPL/WrLp/1u07P9ct/H/XLjy/1it4/85VWLR
KiUYGSsqICs7WmjiVKLR/1am1/9UpNb/U6TW/1Sk1v9TpNb/U6TW/1Sk1v9TpNb/VKTW/1am1/9U
otH/O1po4isqICsuMi0sMkFD4T5idP89VV7/XnB1/2Z5fv9meH7/Znh+/2Z4fv9meH7/Znl+/15w
df89VV7/PmJ0/zJBQ+EuMi0sMS4kBzI+P5pJgKP/TGVw/7K1s//EyMf/w8bG/8PGxv/Dxsb/w8bG
/8TIx/+ytbP/TGVw/0mAov8yPj+aMi4lBwAAAAAtMCk8PV1u7EFoff9UXFr/fIOC/3yDgv98g4L/
fIOC/3yDgv98g4L/VFxa/0Fnff89XW3sLTApPAAAAABDRkcDMCwhCDNDRqNEco7/SldZ/3h+e/98
goD/fIJ//3yCf/98goD/eH57/0pXWP9Eco7/M0NGozAsIQhDRkcDQEREA7GkvwEtMSpDPV5v8D9e
bf9ZZGX/Ym5w/2Jub/9ibm//Ym5w/1lkZf8/Xm3/PV5v8C0xKkOwpL8BQEREBEBERANDRkcDLy0k
CjNBRKM8Wmn7Oldl+TlXZfk5V2X5OVdl+TlXZfk6V2X5PFpp+zNBRKIvLSQKQ0ZHA0BERANAREQD
QEREBEhMTwMvNC8bLjQvSS81MUwvNTFLLzUxSy81MUsvNTFLLzUxTC40L0kvNC8bSExPA0BERARA
REQEQEREA0BERANAREQDRUhJAgAAAACLhI8AAAAAAAAAAAAAAAAAAAAAAJiSnwD///8AR0pLAkBE
RANAREQDQEREAz/8AAAAAAAAgAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAQAAAAAA
AAAAAAAAAAAAAAAAAA/wAAAoAAAAGAAAADAAAAABACAAAAAAAAAJAAAAAAAAAAAAAAAAAAAAAAAA
QEREA0BERANAREQDQEREA0BERANAREQDQEREA0BERANAREQDQEREA0BERANAREQDQEREA0BERANA
REQDQEREA0BERANAREQDQEREA0BERANAREQDQEREA0BERANAREQDQEREA0BERARESEkDaGVuAVhY
XgJYWF0CWFhdAlhYXQJYWF0CWFhdAlhYXQJYWF0CWFhdAlhYXQJYWF0CWFhdAlhYXQJYWF0CWFhd
AlhYXgJlY2sBRUhJA0BERARAREQDQEREA0lLTQMxNzQbLjMudy0yLJAtMiyPLTIsjy0yLI8tMiyP
LTIsjy0yLI8tMiyPLTIsjy0yLI8tMiyPLTIsjy0yLI8tMiyPLTIsjy0yLJAuMy54MTc0HElLTQNA
REQDQEREA0hLTAMuNDCHN1BZ/0Bqgv9AaYH/QGmB/0Bpgf9AaYD/QGmA/0BpgP9AaID/P2d//z9m
fv8+ZX3/PmV9/z5lff8+ZX3/PmV9/z5mfv82TVf/LjQwh0hLTQNAREQDQ0ZHAzU7OAkuNTC1SYCg
/1y48/9btvD/W7bw/1u28P9btvD/W7bw/1u28P9btvD/W7Xv/1qz7v9Yr+r/Vajk/1Ok4f9To+D/
U6Pg/1Sl4/9EdZf/LjUwtDU7OAlCRkcDSUtOAjE2MhIvODbKTY2z/1y48/9ctu//XLbv/1y28P9b
te7/WrHo/1qx6P9asej/WrHo/1qx6P9asun/W7Tt/1mv6v9VpuL/U6Lf/1Ok4v9HgKj/Lzg1yjE2
MhJIS00CYV9nAS8zLh8xPT3dUZnF/1y48v9ctu//XLbv/1y48v9Qlb//OlZi/zpVYP86VWH/OlVh
/zpVYP86VmL/UJW//1y48v9btO3/Vqrl/1Ok4f9Kirf/MTw83S80Lx9dXGMBAAAAAC4yLDAzREbs
VaPT/1y38f9ctu//XLbv/1y48/9JgaH/NktR/0uHqv9Mia3/TImt/0uHqv82S1H/SYGh/1y48/9c
tvD/W7Xv/1er5/9NksX/MkFE6y4yLDD///8AAA0AAC0xK0Q2TFL2WKvf/1y38P9ctu//XLbv/1y4
8v9NjbL/QmyC/1y28P9cuPP/XLjz/1y28P9CbIL/TY2y/1y48v9ctu//XLbw/1u17/9SntT/NUhP
9i4yK0QABQAADhoPAC0wKlw6VmH9WrHo/1y28P9ctu//XLbv/1y28P9asur/Wa/l/1y27/9ctu//
XLbv/1y27/9Zr+X/WrLq/1y28P9ctu//XLbv/1y38P9YreX/OFJe/S0xK1wKFwsABBIEAC0xK3U+
YXL/XLbv/1y38f9ct/H/XLfx/1y38f9ct/H/XLjy/1y38f9ct/H/XLfx/1y38f9cuPL/XLfx/1y3
8f9ct/H/XLfx/1y38f9btu//PmFy/y0xK3UADQAAZ2RtAS0yLZA/ZXj/VqfZ/1am2P9Wptj/VqbY
/1Wm2P9Vptj/VabY/1Wm2P9Vptj/VabY/1Wm2P9Vptj/VabY/1Wm2P9Wptj/VqbY/1am2P9Wp9n/
P2V4/y0yLY9jYWkBQERDAy41MZwyPz//NkxU/zZLUv81Rkr/O01Q/z1PU/89T1P/PU9T/z1PU/89
T1P/PU9T/z1PU/89T1P/PU9T/z1PU/87TVD/NUZK/zZLUv82TFT/Mj8//y41MZw/Q0MDAAAAAC40
L1gyQUP4S4Sp/0mAo/8/Skr/qbCw/7/IyP++xsf/vsbH/77Gx/++xsf/vsbH/77Gx/++xsf/vsbH
/7/IyP+psLD/P0pK/0mAo/9LhKn/MkFC+C40L1gAAAAAS01QAjE2MxIvNjPARneV/0yLtP9HT03/
vL69/8zOzf/KzMv/yszL/8rMy//KzMv/yszL/8rMy//KzMv/yszL/8zOzf+8vr3/Rk9N/0yLtP9G
d5X/LzYzwDE3MhJKTU8CQEREA8283QAtMixgN01V+kqBpP82SU7/OkE+/09WU/9SWlf/UlpX/1Ja
V/9SWlf/UlpX/1JaV/9SWlf/UlpX/09WU/86QT7/NkhO/0qBpP83TVX6LTIsYNjE6ABAREQDQERE
A0lLTQMwNjIWLzYzxkZ4lv9JgaX/RE1K/6etrP+zubn/sri4/7K4uP+yuLj/sri4/7K4uP+yuLj/
s7m5/6etrP9ETEr/SYGl/0Z4lv8vNjPGMDYyFkhLTQNAREQDQEREA0BERASil68BLTIsZzhQWfxI
fp//NEFB/0ZMSf9VXFn/VVxZ/1VcWf9VXFn/VVxZ/1VcWf9VXFn/VVxZ/0ZMSf80QEH/SH2e/zhQ
WfwtMixno5mwAUBERARAREQDQEREA0BERARLTlACMDYxGi83Nc1HeZj/PWF1/09TTv+AhYL/gIWC
/4CFgv+AhYL/gIWC/4CFgv+AhYL/gIWC/09TTv89YXX/R3mY/y83NcwwNTEaS01QAkBERARAREQD
QEREA0BERARAREQEdnN/AS0yLG85UVz9RnaT/ztZZ/87WWj/O1lo/ztZaP87WWj/O1lo/ztZaP87
WWj/O1lo/ztZZ/9GdpP/OFFc/S0yLG90cX4BQEREBEBERARAREQDQEREA0BERARAREQETlBTAjA1
MR0vODbHOFBa/zpVYv86VWH/OlVh/zpVYf86VWH/OlVh/zpVYf86VWH/OlVh/zpVYv84UFr/Lzg2
xzA1MR1OUFMCQEREBEBERARAREQDQEREA0BERARAREQEQEREBEZKSwMvNTEpLTIsYi0xK2YtMStm
LTErZi0xK2YtMStmLTErZi0xK2YtMStmLTErZi0xK2YtMixiLzUxKUZKSwNAREQEQEREBEBERARA
REQDQEREA0BERARAREQEQEREBEBERARKTU8CAAAAAK+qtAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAK2oswAAAAAASkxOAkBERARAREQEQEREBEBERARAREQDQEREA0BERANAREQDQERE
A0BERANAREQDQEREA0BERANAREQDQEREA0BERANAREQDQEREA0BERANAREQDQEREA0BERANAREQD
QEREA0BERANAREQDQEREA0BERANAREQDAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAQCA
AAEAgAABAIAAAQAAAAAAAAAAAIAAAQAAAAAAQAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP/
wAAAAAAAKAAAACAAAABAAAAAAQAgAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAEBERAJAREQDQERE
A0BERANAREQDQEREA0BERANAREQDQEREA0BERANAREQDQEREA0BERANAREQDQEREA0BERANAREQD
QEREA0BERANAREQDQEREA0BERANAREQDQEREA0BERANAREQDQEREA0BERANAREQDQEREA0BERANA
REQDQEREA0BERARAREQEQEREBEFFRQRCRUYEQkZGBEJGRgRCRkYEQkZGBEJGRgRCRkYEQkZGBEJG
RgRCRkYEQkZGBEJGRgRCRkYEQkZGBEJGRgRCRkYEQkZGBEJGRgRCRkYEQkZGBEJGRgRCRUYEQUVF
BEBERARAREQEQEREBEBERANAREQDQEREBEBERARISkwCPEFABDU7OQo1OzkKNTs5CjU7OQo1OzkK
NTs5CjU7OQo1OzkKNTs5CjU7OQo1OzkKNTs5CjU7OQo1OzkKNTs5CjU7OQo1OzkKNTs5CjU7OQo1
OzkKNTs5CjU7OQo8QUAESUxNAkBERARAREQEQEREA0BERANAREQETE5RAjA3MyQuNDCSLjMtty4z
LbcuMy23LjMtty4zLbcuMy23LjMtty4zLbcuMy23LjMtty4zLbcuMy63LjMuty4zLrcuMy63LjMu
ty4zLrcuMy63LjMuty4zLrcuMy63LjMuty40MJMwNzMkTE5RAkBERARAREQDQEREA0JGRgQ2OzkJ
LjUwozJAQv85VWP/OVVk/zlVY/85VWP/OVVj/zlVY/85VWP/OVVj/zlVY/85VWP/OVVj/zlUY/85
VGL/OFRi/zlUYv85VGL/OVRi/zlUYv85VGL/OVRi/zlUYv84VGH/Mj9B/y41MKM2PDkJQkZGBEBE
RANAREQDSkxOAzE3NBouMy7VQGl+/1mw6f9ZsOj/WbDo/1mv6P9Zr+j/Wa/o/1mv6P9Zr+f/Wa/n
/1mv5/9Yruf/WK3m/1eq5P9Vp+D/U6Pd/1Kg2/9SoNr/UqDb/1Kg2/9SoNv/UqDb/1Kg2/89Ynj/
LjMu1TE3NBlKTE4DQEREA0BERANbW2ECMDYzKS40L+ZGepb/XLjz/1y28P9ct/D/XLfw/1y38P9c
t/D/XLfw/1y38P9ct/D/XLfw/1y38P9ct/D/XLfw/1y28P9btO7/WK/p/1Wo4/9To9//U6Lf/1Oj
3/9To9//U6Ti/0Fvjf8uNC/mMDYzKVtaYAJAREQDQEREA6qctAEvNjI8LjYy8kuHqf9cuPP/XLbv
/1y27/9ctu//XLbv/1y27/9ctu//W7Ts/1uz6/9bs+v/W7Pr/1uz6/9bs+v/W7Pr/1u07P9ctvD/
W7Xv/1iv6f9UpuH/U6Lf/1Oi3/9TpOL/RXqf/y42MvIvNjI8qJqyAUBERANAREQDAAAAAC81MVMw
OTf7T5O8/1y48v9ctu//XLbv/1y27/9ctu//XLfx/0+Tu/88W2n/O1hl/ztYZf87WGX/O1hl/ztY
Zf87WGX/PFtp/0+Tu/9cuPH/XLbw/1qz7f9VqOT/U6Lf/1Ok4f9Jha//Lzk3+y81MVIAAAAAQERE
A0BERAMAAAAALjQwazE+P/9Tnsz/XLjy/1y27/9ctu//XLbv/1y27/9cuPL/RXWP/y82Mv85VF7/
O1ll/ztYZf87WGX/O1ll/zlUXv8vNjL/RXWP/1y48v9ctu//XLbw/1u17v9WquX/U6Th/0yOvv8x
PT3/LjQwawAAAABAREQDQEREA3RvewEuMy+FNEVJ/1an2f9ct/H/XLbv/1y27/9ctu//XLbv/1y4
8v9EdI7/M0JD/1Wk1P9btOz/W7Pr/1uz6/9btO3/VaTU/zNCQ/9EdI7/XLjy/1y27/9ctu//XLbw
/1u17v9WquX/TpXK/zNDR/8uNC+FdG97AUBERANBRUUDP0NDBC4zLp83Tlb/Wa7j/1y38P9ctu//
XLbv/1y27/9ctu//XLjy/0qFp/87Wmj/WKzh/1y38f9ctvD/XLbw/1y38f9YrOH/O1to/0qFp/9c
uPL/XLbv/1y27/9ctu//XLbw/1u07v9Sn9f/NUpT/y4zLp8/Q0MEQUVFA0RHSAI1OzgKLTMttztZ
Zv9as+v/XLbw/1y27/9ctu//XLbv/1y27/9ctvD/WrLq/1it4v9ctu//XLbv/1y27/9ctu//XLbv
/1y27/9YreL/WrLq/1y28P9ctu//XLbv/1y27/9ctu//XLfw/1it5f85VGL/LjMutzU7OApDR0cD
TU9SAjE4NRQtMy3NP2Z5/1y27/9ctu//XLbv/1y27/9ctu//XLbv/1y27/9ctvD/XLfw/1y27/9c
tu//XLbv/1y27/9ctu//XLbv/1y38P9ctvD/XLbv/1y27/9ctu//XLbv/1y27/9ctvD/W7Xv/z5k
d/8tMy3MMTg1FEtNUAJ/eIYBMDczIS4zLt9EdI3/XLnz/1y38f9ct/H/XLfx/1y38f9ct/H/XLfx
/1y38f9ct/H/XLfx/1y38f9ct/H/XLfx/1y38f9ct/H/XLfx/1y38f9ct/H/XLfx/1y38f9ct/H/
XLfx/1y38f9cufP/RHSN/y4zLt8wNzMhbmp0AQAAAAAvNjIzLjUw7UV2kf9XqNv/VqbY/1am2P9W
ptj/VqbY/1am2P9Wptj/VqbY/1am2P9Wptj/VqbY/1am2P9Wptj/VqbY/1am2P9Wptj/VqbY/1am
2P9Wptj/VqbY/1am2P9Wptj/VqbY/1eo2/9FdpH/LjUw7S82MjIAAAAACBYJAC82MkMuNTH2Mj8/
/zNER/8zQ0b/M0RH/zRFSP8yQ0b/MkNG/zJDRv8yQ0b/MkNG/zJDRv8yQ0b/MkNG/zJDRv8yQ0b/
MkNG/zJDRv8yQ0b/MkNG/zJDRv8yQ0b/NEVI/zNER/8zQ0b/M0RH/zI/QP8uNTH2LzYyQwMSBAB+
eIYBMDczIy40MNgzQUP/QmqB/0NviP86VmL/Mzo1/213df99iIf/fIeG/3yHhv98h4b/fIeG/3yH
hv98h4b/fIeG/3yHhv98h4b/fIeG/3yHhv98h4b/fYiH/213df8zOjX/OlVi/0NviP9BaoH/M0FD
/y40MNgwNzMjcGx3AUFFRQNKTE8CLjQwfzE9Pf9Ojbb/Wazl/0Jvif9ESkb/2N3e//T5+v/y9/j/
8vf4//L3+P/y9/j/8vf4//L3+P/y9/j/8vf4//L3+P/y9/j/8vf4//L3+P/0+fr/2N3d/0RKRv9C
b4n/Wazl/06Ntv8xPT3/LjQwf0tNTwJBREUDQEREA1lZXwIwNjMoLjMv3T5fcf9Xptv/PWBz/0dM
R/+2uLb/wsTD/8HDwv/Bw8L/wcPC/8HDwv/Bw8L/wcPC/8HDwv/Bw8L/wcPC/8HDwv/Bw8L/wcPC
/8LEw/+1uLb/R0tH/z1gc/9Xptv/PmBx/y4zL90wNjMoWVleAkBERANAREQDQUVFBEJGRwMuNDCH
Mj4//06Ot/8+YHL/MDcz/zM6Nv80PDj/Nj05/zY9Of82PTn/Nj05/zY9Of82PTn/Nj05/zY9Of82
PTn/Nj05/zY9Of82PTn/NDw4/zM6Nv8wNzP/PmBy/06Ntv8xPj7/LjQwh0NGRwNBRUUEQEREA0BE
RANAREQEY2JqATA2My0uNC/iP2N3/1KXxf9EcIv/MTo3/4WNi/+vuLn/rba2/622tv+ttrb/rba2
/622tv+ttrb/rba2/622tv+ttrb/rba2/6+4uf+FjYv/MTo3/0Rwiv9Sl8b/P2N3/y40L+IvNjIt
Y2FpAUBERARAREQDQEREA0BERARBRUUEPUJBBC40MJAyQEH/UZTB/0h8nf8yODT/fIB+/5ebmf+V
mZf/lZmX/5WZl/+VmZf/lZmX/5WZl/+VmZf/lZmX/5WZl/+VmZf/l5uZ/3uAfv8yODT/SHyd/1GU
wf8yQEH/LjQwjz5CQgRBRUUEQEREBEBERANAREQDQEREBEBERARva3YBLzYyMy40L+ZBaX//SX6f
/zI+P/8uNTH/PkVC/0NLSP9DS0f/Q0tH/0NLR/9DS0f/Q0tH/0NLR/9DS0f/Q0tH/0NLSP8+RUL/
LjUx/zI+P/9Jfp//QWh+/y40L+YvNjIzcGx3AUBERARAREQEQEREA0BERANAREQEQEREBEFFRQQ5
Pz0GLjQvmDNCRP9Qk77/RHGM/zU8N/+Jj43/oKal/5+lo/+fpaP/n6Wj/5+lo/+fpaP/n6Wj/5+l
o/+fpaP/oKal/4mOjf81PDj/RHGM/1CTvv8zQkT/LjQvlzk+PQZBRUUEQEREBEBERARAREQDQERE
A0BERARAREQEQEREBIJ7iQEvNjI5LjQw6kJthf9GeJb/MDk3/zU+PP82Pz3/Nj89/zY/Pf82Pz3/
Nj89/zY/Pf82Pz3/Nj89/zY/Pf82Pz3/NT48/zA5N/9Gd5X/QmyF/y40MOovNjI5gnuKAUBERARA
REQEQEREBEBERANAREQDQEREBEBERARAREQEQkZGBDc9OwcuNC+gNERH/0qDp/9He5r/RniX/0Z4
l/9GeJf/RniX/0Z4l/9GeJf/RniX/0Z4l/9GeJf/RniX/0Z4l/9GeJf/R3ua/0qDp/80REj/LjQv
nzc8OgdCRkYEQEREBEBERARAREQEQEREA0BERANAREQEQEREBEBERARAREQEeXSAAS82MjsuNTLh
MkBB/zRFSf80RUn/NEVJ/zRFSf80RUn/NEVJ/zRFSf80RUn/NEVJ/zRFSf80RUn/NEVJ/zRFSf80
RUn/MkBB/y41MuAvNjI6eXOAAUBERARAREQEQEREBEBERARAREQDQEREA0BERARAREQEQEREBEBE
RARBREUEPkNDBC82MjouNDB7LjQvgi40L4EuNC+BLjQvgS40L4EuNC+BLjQvgS40L4EuNC+BLjQv
gS40L4EuNC+BLjQvgS40L4IuNDB7LzYyOj9DQwRBREUEQEREBEBERARAREQEQEREBEBERANAREQD
QEREBEBERARAREQEQEREBEBERARBRUUEUFFVAb+vyQCyo70BsqO9AbKivAGxobsBsaG7AbKivAGy
o70BsqK8AbGhuwGxobsBsqK8AbKjvQGyorwBsaG7AdC93ABOUVMBQUVFBEBERARAREQEQEREBEBE
RARAREQEQEREA0BERANAREQEQEREBEBERARAREQEQEREBEBERARAREQEQEREBEBERARAREQEQERE
BEBERARAREQEQEREBEBERARAREQEQEREBEBERARAREQEQEREBEBERARAREQEQEREBEBERARAREQE
QEREBEBERARAREQEQEREBEBERARAREQDQEREAkBERANAREQDQEREA0BERANAREQDQEREA0BERANA
REQDQEREA0BERANAREQDQEREA0BERANAREQDQEREA0BERANAREQDQEREA0BERANAREQDQEREA0BE
RANAREQDQEREA0BERANAREQDQEREA0BERANAREQDQEREA0BERAIAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAEAAAAJAAAACAAAAAAAAAAAAAAAAAAAAAAAAAACAAAABgAAAAQAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAQAAAAAAAAAAACgAAAAw
AAAAYAAAAAEAIAAAAAAAACQAAAAAAAAAAAAAAAAAAAAAAABAREQBQEREA0BERAJAREQDQEREAkBE
RANAREQCQEREA0BERAJAREQCQEREA0BERAJAREQDQEREAkBERANAREQCQEREA0BERAJAREQDQERE
AkBERANAREQCQEREA0BERAJAREQCQEREA0BERAJAREQDQEREAkBERANAREQCQEREA0BERAJAREQD
QEREAkBERANAREQCQEREA0BERAJAREQCQEREA0BERAJAREQDQEREAkBERANAREQCQEREA0BERAFA
REQCQEREA0BERARAREQDQEREBEBERARAREQEQEREBEBERARAREQEQEREA0BERARAREQDQEREBUBE
RANAREQFQEREA0BERARAREQDQEREBEBERARAREQEQEREBEBERARAREQEQEREA0BERARAREQDQERE
BUBERANAREQFQEREA0BERARAREQDQEREBEBERARAREQEQEREBEBERARAREQEQEREA0BERARAREQD
QEREBUBERANAREQFQEREA0BERANAREQCQEREBEBERANAREQEQEREBEBERARAREQEQEREBEBERARA
REQEQEREBEBERANAREQFQEREA0BERAVAREQDQEREBUBERANAREQEQEREBEBERARAREQEQEREBEBE
RARAREQEQEREBEBERANAREQFQEREA0BERAVAREQDQEREBUBERANAREQEQEREBEBERARAREQEQERE
BEBERARAREQEQEREBEBERANAREQFQEREA0BERAVAREQDQEREBUBERAJAREQDQEREA0BERAVAREQD
QEREBEBERARDR0gDX19lAWBfZgFaWmABYmFoAVpaYAFkYmoBWlpgAmVjawFbWmACY2FpAVxbYQJg
X2YBXVxiAV1cYwFeXWQBW1thAWBfZgFaWmABYmFoAVpaYAFkYmoBWlpgAmVjawFbWmACY2FpAVxb
YQJgX2YBXVxiAV1cYwFeXWQBW1thAWBfZgFaWmABYF9mAUNHRwNAREQDQEREBUBERANAREQFQERE
A0BERANAREQCQEREBUBERANAREQFQEREA0lLTQIxNzQSLzYyMC82MjYvNjI1LzYyNi82MjUvNjI2
LzYyNS82MzYvNjI1MDYzNi82MjUwNjM2LzYyNS82MzYvNjI2LzYyNS82MjYvNjI1LzYyNi82MjUv
NjI2LzYyNS82MzYvNjI1MDYzNi82MjUwNjM2LzYyNS82MzYvNjI2LzYyNS82MjYvNjI1LzYzMTE3
NBJIS00CQEREA0BERAVAREQDQEREBUBERAJAREQDQEREA0BERAVAREQDSEtNAy82MjouNTG7LjUx
7C41Me8uNTHvLjUx7i41Me8uNTHvLjUx7y41Me8uNTHvLjUw7y41Me4uNTDvLjUx7i41Me8uNTHu
LjUx7y41Me4uNTHvLjUx7i41Me8uNTHvLjUx7y41Me8uNTHvLjUw7y41Me4uNTDvLjUx7i41Me8u
NTHuLjUx7y41Me4uNTHvLjUx7C41Mb0vNjI6SEtMA0BERANAREQFQEREA0BERANAREQCQEREBUBE
RANLTU8DMDczHi41McsuNTL/MDo5/zE8PP8wPDz/MTw8/zA8PP8xPDz/MDw8/zE8PP8wPDz/MTw8
/zA8PP8xPDz/MDw8/zE8PP8wPDz/MTw8/zE8PP8xPDz/MTw8/zE8PP8xPD3/MTw8/zE8Pf8xPDz/
MTw9/zE8PP8xPD3/MTw8/zE8Pf8xPDz/MTw8/zE8PP8xPD3/MDo5/y42Mv8uNTHLMDczHktNUANA
REQDQEREBEBERAJAREQDQEREA0BERAUAAAAALzYyVC40MPozQkX/S4iw/0+Uw/9PlMP/TpPC/06U
wv9Ok8H/TpPC/06Twv9Ok8H/TpPB/06Swf9Ok8H/TpLA/06Swf9OksD/TpLB/02Rv/9NkMD/TI6+
/0yOvf9Ljbz/S428/0uNvP9Ljbz/TI29/0uNvP9Mjb3/S428/0yNvf9LjLz/TI29/0uMvP9Mjr7/
SIGp/zJBRP8uNTD6LzYyVAAAAABAREQEQEREA0BERANAREQBQEREBEBERAO1pcABLjUycC40L/84
Ulv/WbDm/1y48v9ct/H/XLfy/1y38f9ct/H/XLfx/1y38f9ct/H/XLfx/1y38f9ct/H/XLfx/1y2
8f9ct/H/XLbw/1y38f9btfD/W7Xv/1my7f9Yrur/Vqrm/1Sm4/9TpOH/U6Pg/1Ok4f9To+D/U6Th
/1Oj4P9TpOH/U6Pg/1Ok4f9TpOH/UZ7X/zZNV/8uNC//LzYyb////wBAREQEQEREBEBERAJAREQD
QEREA0BERARjYWoBLzYyii4zLv88XWz/W7Ts/1y27/9ctvD/XLbv/1y28P9ctu//XLbv/1y27/9c
tu//XLbw/1y27/9ctvD/XLbv/1y28P9ctu//XLbw/1y27/9ctvD/XLbv/1y38P9ctu//W7bv/1qz
7f9Yruj/Vafj/1Oj3/9Tot//U6Le/1Oj3/9Tot7/U6Pf/1Oi3v9To9//UqDb/zpXZ/8uNC//LjUx
iltaYQJAREQEQEREBEBERAJAREQCQEREBEFFRQM7QD8GLjUxoy4zLv9Ban//XLbv/1y28P9ctu//
XLbw/1y27/9ctvD/XLbv/1y27/9ctu//XLbv/1y28P9ctu//XLbw/1y27/9ctvD/XLbv/1y28P9c
tu//XLbw/1y27/9ctvD/XLbv/1y28P9ctvD/W7Xu/1iv6v9Vp+L/U6Pf/1Oi3v9To9//U6Le/1Oj
3/9Tot7/U6Pf/z1hd/8uNC7/LjUxojtAPgVBRUUEQEREBEBERANAREQDQEREBENGRwQzOTYMLjUx
uy40L/9Fd5L/XLjy/1y27/9ctvD/XLbv/1y28P9ctu//XLbw/1y27/9ctu//XLbv/1y38f9ct/D/
XLbv/1y38P9ctu//XLfw/1y27/9ct/D/XLbv/1y28P9ctu//XLbw/1y28P9ct/H/XLbw/1y27/9b
te7/V63n/1Sk4P9Tot7/U6Pf/1Oi3v9To9//U6Th/0Ftiv8uNC//LjUxuzQ6NwxDRkcDQEREBEBE
RAJAREQCQEREBEhLTAMxODQXLjUx0C41Mf9KhKb/XLjy/1y28P9ctu//XLbw/1y27/9ctvD/XLbv
/1y28P9ctu//XLfw/1CVvv9AaX7/QGh8/0Bne/9AaHz/QGd7/0BofP9AaHz/QGh8/0BofP9AZ3v/
QGh8/0Bpfv9Qlb//XLfw/1y27/9ctu//XLbw/1mx6/9Up+L/U6Le/1Oj3/9Tot7/U6Ti/0R3mv8u
NTH/LjUxzzE3NBZHSkwDQEREBEBERANAREQDQEREBFZWWwIwNzMlLjUx4S84Nv9OkLf/XLjz/1y2
7/9ctvD/XLbv/1y28P9ctu//XLbw/1y27/9ctvD/W7Ts/z1ebv8tMSv/LTIs/y0xK/8tMSv/LTEr
/y0xK/8tMSv/LTEr/y0xK/8tMSv/LTIs/y0xK/88Xm3/W7Ts/1y28P9ctu//XLbv/1y38P9as+3/
Vajk/1Oi3v9To9//U6Th/0iDrP8vODb/LjUx4TA3MyVZWV8BQEREBEBERAJAREQCQEREBHVwfAEv
NjI2LjUx7zE9Pf9SnMn/XLfx/1y28P9ctu//XLbw/1y27/9ctvD/XLbv/1y28P9ctu//W7Pr/zta
Z/8tMy3/N05W/0Bpff9AZ3v/QGh8/0Bne/9AaHz/QGh8/0BofP9AaH3/N09X/y0zLf87Wmj/WrPr
/1y28P9ctu//XLbv/1y27/9ctvD/W7Tu/1ap5P9Tot7/U6Th/0uLuv8wPDz/LjUx7i82MjZraHIB
QEREA0BERANAREQCQEREBAAAAAAvNjJNLjQw+DRER/9Vpdb/XLfx/1y27/9ctvD/XLbv/1y28P9c
tu//XLbw/1y27/9ct/D/WrPq/ztbaP8tMiz/RXWQ/1y48v9ctu//XLbw/1y27/9ctvD/XLbv/1y3
8P9cuPL/RXaR/y0yLP87Wmj/WrPr/1y28P9ctu//XLbv/1y27/9ctu//XLbw/1u07f9VqOT/U6Pg
/06UyP8yQkX/LjQw+C82MkwAAAAAQEREBEBERAJAREQCQEREA////wAvNjJjLjQv/jZNVP9YrOH/
XLfw/1y28P9ctu//XLbw/1y27/9ctvD/XLbv/1y28P9ctu//W7Pr/ztaZ/8tMCr/RXaR/1y48v9c
tvD/XLbv/1y28P9ctu//XLbw/1y27/9cuPL/RXWQ/ywwKv87Wmj/W7Pr/1y27/9ctvD/XLbv/1y2
7/9ctu//XLbv/1y28P9as+z/VKfj/1CZ0f81SVD/LjQv/i82MmP94f8AQEREA0BERANAREQCQERE
BP///wAvNjJ+LjMu/zpYZP9asun/XLbw/1y27/9ctvD/XLbv/1y28P9ctu//XLbw/1y27/9ctvD/
W7bv/0d6l/82S1H/TpC4/1y48f9ctu//XLbv/1y27/9ctvD/XLbv/1y28P9ct/H/TpG4/zZLUf9G
epf/W7bv/1y28P9ctu//XLbw/1y27/9ctu//XLbv/1y27/9ct/D/WbDq/1Kg2v84Ul//LjQv/y82
Mn4AAAAAQEREBUBERAJAREQDQEREA0JGRwQuNTGXLjMu/z5jdf9bte7/XLbw/1y27/9ctu//XLbw
/1y27/9ctvD/XLbv/1y28P9ctu//XLfw/1qy6v9Yq9//W7Xt/1y28P9ctu//XLbv/1y27/9ctu//
XLbw/1y27/9ctvD/W7Xt/1ir3/9asur/XLfw/1y27/9ctvD/XLbv/1y28P9ctu//XLbv/1y27/9c
tu//XLbw/1aq5f87XG//LjQv/y41MZdCRkcEQEREA0BERANAREQCQUVFBDU7OQguNTGwLjMv/0Nx
if9ct/H/XLbv/1y27/9ctu//XLbv/1y28P9ctu//XLbw/1y27/9ctvD/XLbv/1y38P9ct/D/XLbw
/1y27/9ctvD/XLbv/1y27/9ctu//XLbv/1y28P9ctu//XLbw/1y38P9ct/D/XLbv/1y28P9ctu//
XLbw/1y27/9ctvD/XLbv/1y27/9ctu//XLbv/1u17/9Ba4T/LjMv/y41MbA1OzkIQUVFBEBERAJA
REQDRklLAjI5NRIuNTHGLjUw/0h+nP9cuPL/XLbw/1y27/9ctu//XLbv/1y27/9ctvD/XLbv/1y2
8P9ctu//XLbw/1y27/9ctvD/XLbv/1y28P9ctu//XLbw/1y27/9ctu//XLbv/1y27/9ctvD/XLbv
/1y28P9ctu//XLbw/1y27/9ctvD/XLbv/1y28P9ctu//XLbw/1y27/9ctu//XLbv/1y48v9HfJr/
LjQw/y41McYyOTYSRklLAkBERANAREQCSkxPAzA3Mx0uNTHZLzcz/0yLr/9cuPP/XLbv/1y28P9c
tu//XLbv/1y27/9ctu//XLbw/1y27/9ctvD/XLbv/1y28P9ctu//XLbw/1y27/9ctvD/XLbv/1y2
8P9ctu//XLbv/1y27/9ctu//XLbw/1y27/9ctvD/XLbv/1y28P9ctu//XLbw/1y27/9ctvD/XLbv
/1y28P9ctu//XLbv/1y48/9Mi6//Lzcz/y41MdkwNzMcSkxPA0BERAJAREQDh3+PATA2My4uNTHp
MDs6/1GYwv9dufP/XLfx/1y38f9ct/H/XLfx/1y38f9ct/H/XLfx/1y38f9ct/H/XLfx/1y38P9c
t/H/XLfw/1y38f9ct/D/XLfx/1y38f9ct/H/XLfx/1y38f9ct/H/XLfx/1y38f9ct/H/XLfx/1y3
8P9ct/H/XLfw/1y38f9ct/D/XLfx/1y38f9ct/H/XLfx/1259P9Rl8H/MDs5/y41MekwNjMugXqJ
AUBERANAREQBjYSWAS82MkEuNTD0Mj8//0+Su/9XqNr/VqbY/1an2f9Wptj/VqbY/1am2P9Wptj/
VqfY/1am2P9Wp9n/VqbY/1an2f9Wptj/VqfZ/1am2P9Wp9n/VqbY/1an2f9Wptj/VqbY/1am2P9W
ptj/VqfY/1am2P9Wp9n/VqbY/1an2f9Wptj/VqfZ/1am2P9Wp9n/VqbY/1an2f9Wptj/VqbY/1ao
2v9Pk7v/MT4//y41MPQvNjJAi4KTAUBERAJAREQDAAAAAC82MlkuNTH8Lzc0/zNDRf80RUn/NEVI
/zRFSf80RUj/NEVJ/zRFSP80RUn/NEVI/zRFSf80RUj/NEVI/zRFSP80RUj/NEVI/zRFSP80RUn/
NEVI/zRFSf80RUj/NEVJ/zRFSP80RUn/NEVI/zRFSf80RUj/NEVI/zRFSP80RUj/NEVI/zRFSP80
RUn/NEVI/zRFSf80RUj/NEVJ/zRFSP8zQ0b/Lzc0/y41MfwvNjJaAAAAAEBERAJAREQC9Nn/AC82
MlAuNTH3LjUx/y82Mv8vNzT/Lzc0/y83NP8vNzT/LjUw/y40MP8xNzP/Mjg0/zI4NP8yODT/Mjg0
/zI4NP8yODT/Mjg0/zI4NP8yODT/Mjg0/zI4NP8yODT/Mjg0/zI4NP8yODT/Mjg0/zI4NP8yODT/
Mjg0/zI4NP8yODT/Mjg0/zE3M/8uNDD/LjUw/y83M/8vNzT/Lzc0/y83NP8vNjL/LjUx/y41Mfgv
NjJQ7NP6AEBERANAREQDSEtNAzE4NBYuNTHELjQw/zdOVv9LhKj/TIet/0yHrf9HeJb/MDw7/zM6
Nv+Bjo7/nqyt/5upqv+cqqv/m6mq/5yqq/+cqar/nKqq/5yqq/+bqar/nKqr/5upqv+cqqv/m6mq
/5yqq/+bqar/nKqr/5upqv+cqqv/m6mq/5yqq/+cqar/naus/4KOjv8zOjb/MDs7/0Z4lf9MiK7/
TIas/0uEqf83TVX/LjQw/y41McIxODQWSEpMA0BERAJAREQCQEREBId+jwEvNTJjLjUw+zI/QP9P
kbv/Wari/1mr4/9OjLT/Lzk3/0BGQ//M09P/7PL0/+vx8//q8fL/6vHy/+rx8v/q8fL/6vHy/+rx
8v/q8fP/6vHy/+vx8//q8PL/6/Hz/+rw8v/r8fP/6vHy/+vx8//q8fL/6vHy/+rx8v/q8fL/7PP0
/8zS0v8/RkL/Lzk4/06Ntf9Zq+P/Wavj/0+Quv8yP0D/LjUw+y82MmSNhJUBQEREBEBERANAREQD
QEREBEtNTwIxNzQZLjUxyS40L/8/Y3b/V6bc/1ip4P9Jf6D/LTQw/1BWU//s7Oz/////////////
////////////////////////////////////////////////////////////////////////////
/////////////////////////////+zt7P9QVlP/LDQw/0l+n/9YquH/V6bc/z9jd/8uNC//LjUx
yTE4NBlMTlACQEREBEBERAJAREQCQEREBEBERAR4cn8BLzUybS41MPwyQEH/T5C7/1mr4v9EcYz/
LDIu/0tRTv+lqKb/rK+t/6uurf+srq3/q66s/6yvrf+rrqz/rK+t/6uurP+sr63/q66s/6yvrf+r
rqz/rK+t/6uurP+sr63/q66t/6uurf+srq3/q66s/6yvrf+rrqz/rK+u/6Snpv9KUE3/LDMu/0Ry
jf9ZquL/T5G8/zJAQf8uNTD8LzYybJiMoAFAREQEQEREA0BERANAREQCQEREBEBERARNT1ECMDcz
HS41MdAuNC//QGd9/1in3v9AZnr/LTIs/y40MP8uNTH/LjUx/y0zL/8sMy//LDMv/ywzL/8sMy//
LDMv/ywzL/8sMy//LDMv/ywzL/8sMy//LDMv/ywzL/8sMy//LDMv/ywzL/8sMy//LDMv/ywzL/8t
My//LjUx/y41Mf8uNDD/LTIs/0Blef9YqN7/QGd8/y40L/8uNTHPMDYzHEpNTwNAREQDQEREBEBE
RAJAREQCQEREA0BERARAREQEVFVZAi81MnMuNDD+M0JE/1GVwv9LhKn/N09X/zRFSv8uNjL/MTg1
/0dQTv9MVVP/TFVS/0xVUv9MVVP/TFVS/0xVU/9MVVL/TFVT/0xVUv9MVVP/TFVS/0xVU/9MVVL/
TFVT/0xVUv9MVVL/TFVS/0xVU/9IUE7/MTk1/y42Mv80RUn/OE9Y/0uEqf9RlMH/M0JE/y41MP4u
NTFzVFVaAkBERANAREQFQEREA0BERANAREQCQEREBEBERANAREQEVVZbAjA3MyIuNTHVLjQw/0Fq
gf9Yp97/VqPX/0d5l/8tNDH/SlFO/8bP0P/X4eL/1d/g/9bg4f/V3+D/1uDh/9Xf4P/W3+H/1t/h
/9bf4f/W3+H/1t/g/9bg4f/V3+D/1uDh/9Xf4P/W4OH/1d/g/9fh4v/Gz9D/SlFO/y00Mf9HeZf/
VqPX/1in3f9CaoH/LjQw/y41MdUwNzMiWllfAUBERAVAREQDQEREBUBERAJAREQDQEREA0BERAVA
REQDQEREBFJTVwIvNTJ+LjQw/zRESP9RlsP/Wari/0Jthf8sMi3/U1lW/7y+vf/Bw8L/wsTD/8HD
wv/Bw8L/wcPC/8HDwv/CxML/wcPC/8LEw//Bw8L/wsTD/8HDwf/CxMP/wcPC/8LEw//Bw8L/wsTD
/8HDwv+7vrz/UlhV/ywyLf9DbYb/Wari/1GWw/80REf/LjQw/y82MnxVVVoCQEREBEBERANAREQF
QEREA0BERANAREQCQEREBUBERANAREQFQEREA1FSVgIvNjImLjUx2i41MP9Db4j/V6fd/zxba/8t
My3/MDcz/zM6Nv8yOTX/Mjk1/zI5Nf8yOTX/Mjk1/zI5Nf8yOTX/Mjk1/zI5Nf8yOTX/Mjk1/zI5
Nf8yOTX/Mjk1/zI5Nf8yOTX/Mjk1/zI5Nf8zOjb/MDcz/y0yLf88Wmr/V6bc/0Nuh/8uNTD/LjUx
2i82MiZRUlYCQEREA0BERAVAREQDQEREBUBERAJAREQDQEREA0BERAVAREQDQEREBUFFRQNCRkYD
LjUxgy40MP80Rkv/UpnH/0V0kP8zQkT/Lzcz/y41Mf88REH/QkpH/0JKR/9CSkf/QkpH/0JKR/9C
Skf/QkpH/0JKR/9CSkf/QUpG/0JKR/9BSkb/QkpH/0FKRv9CSkf/QkpH/zxEQf8uNTH/Lzcz/zNC
RP9Fc4//UpjH/zRGS/8uNDD/LjUyhEJGRgNBRUUDQEREBEBERANAREQFQEREA0BERANAREQCQERE
BUBERANAREQFQEREA0BERAV0b3sBMDYzLS41MeAuNTH/RHGM/1en3f9NirH/MT0+/zQ7N/+jqaj/
yc/P/8jOzv/Hzc3/yM7O/8fNzf/Izs7/x83N/8jOzv/Hzc3/yM7O/8fNzf/Hzc3/yM7O/8fNzf/I
zs7/yc/P/6Kop/81Ozf/MT4+/02Ksf9Xp93/RHKN/y41Mf8uNTHfMDYyLGFgZwFAREQEQEREBEBE
RARAREQDQEREBEBERAJAREQDQEREA0BERAVAREQDQEREBUBERANBRUUEPkNCBC41Mo0uNC//NklP
/1Sczf9Ojrf/MDs5/zA3M/9QVVL/Wl9c/1leW/9ZXlv/WV9b/1leW/9ZX1v/WV5b/1lfW/9ZXlv/
WV9b/1leW/9ZX1v/WV5b/1lfW/9ZXlv/Wl9c/09VUv8wNzP/MDo5/06Ot/9UnM3/NUlP/y40MP8u
NTGMP0NDBEFFRQRAREQEQEREBEBERARAREQEQEREA0BERANAREQBQEREBEBERANAREQFQEREA0BE
RAVAREQDWVheAi82MjAuNTHkLjYy/0Z4lf9PkLr/MT4+/y41MP8sMy//LDMv/ywzL/8sMy//LDMv
/ywzL/8sMy//LDMv/ywzL/8sMy//LDMv/ywzL/8sMy//LDMv/ywzL/8sMy//LDMv/ywzL/8uNTD/
MT4+/0+Puf9Gd5X/LjYy/y41MeQwNjMxdnF9AUBERARAREQEQEREBEBERARAREQEQEREBEBERAJA
REQDQEREA0BERARAREQDQEREBUBERANAREQFQUVGAztAPwYuNTGULjQv/zZLUv9Tmsn/TYqx/0h8
nP9IfZ3/SHyc/0h8nf9IfJ3/SHyc/0h8nf9IfJz/SH2d/0h8nP9IfZ3/SHyc/0h9nf9IfJz/SH2d
/0h8nP9IfZ3/SHyc/0h8nf9IfJz/TYmw/1Oayf82S1P/LjQv/y81MZQ5PTwFQUVFBEBERARAREQE
QEREBEBERARAREQEQEREBEBERAJAREQCQEREBEBERARAREQEQEREA0BERAVAREQDQEREBf/2/wAv
NjI5LjUx6C83NP89XG3/RHGL/0Rwiv9EcYv/RHCK/0Rxi/9EcIr/RHGL/0Rwiv9EcIv/RHCK/0Rw
iv9EcIr/RHCK/0Rwi/9EcIr/RHGL/0Rwiv9EcYv/RHCK/0Rxi/9EcIr/RHGL/z1dbf8vNzT/LjUx
6C82MjdhX2cCQEREA0BERARAREQEQEREBEBERARAREQEQEREBEBERANAREQDQEREBEBERARAREQE
QEREBEBERANAREQFQEREA0FFRQQ3PTsGLjUyhS41MfkuNC//LjQv/y40L/8uNC//LjQv/y40L/8u
NC//LjQv/y40L/8uNC//LjQv/y40L/8uNC//LjQv/y40L/8uNC//LjQv/y40L/8uNC//LjQv/y40
L/8uNC//LjQv/y40L/8uNTH5LjUxgzk+PQdCRkYDQEREBUBERANAREQEQEREBEBERARAREQEQERE
BEBERAJAREQCQEREBEBERARAREQEQEREBEBERARAREQDQEREBUBERANER0gEMTg1DS82MmQuNTGr
LjUxty41MbYuNTG3LjUxti41MbcuNTG2LjUxty41MbYuNTG3LjUxti41MbcuNTG2LjUxti41Mbcu
NTG2LjUxty41MbYuNTG3LjUxti41MbcuNTG2LjUxty41MasvNjJiNDo3DkhKTAJAREQFQEREA0BE
RAVAREQDQEREBEBERARAREQEQEREBEBERANAREQDQEREBEBERARAREQEQEREBEBERARAREQEQERE
A0BERAVAREQDQkZGBEVISQE4PTsINDo4CTU7OQs1OzgKNTs4CjU7OAo1OzgKNTs5CjU7OAo1OzkK
NDo4CTY7OQs0OjgJNjs5CzQ6OAk2OzkLNDo4CTU7OQs1OzgKNTs4CjU7OAo1OzgKNTs5Cjc8Ogde
XWQCRUhKA0BERAVAREQDQEREBUBERANAREQFQEREA0BERARAREQEQEREBEBERAJAREQCQEREBEBE
RARAREQEQEREBEBERARAREQEQEREBEBERANAREQFQEREA0BERAVCRUYDQkVGBEJGRwNCRUYEQkZG
A0JGRgRCRkYDQkZGA0JGRgRCRkYDQkVGBEJGRwNCRUYEQ0ZHA0JFRgRDRkcDQkVGBEJGRwNCRUYE
QkZGA0JGRgRCRkYDQkZGA0FFRQRAREQEQEREBEBERANAREQFQEREA0BERAVAREQDQEREBUBERANA
REQEQEREA0BERANAREQCQEREBEBERARAREQEQEREBEBERARAREQEQEREBEBERARAREQDQEREBUBE
RANAREQFQEREA0BERAVAREQDQEREBEBERARAREQEQEREBEBERARAREQEQEREBEBERARAREQDQERE
BUBERANAREQFQEREA0BERAVAREQDQEREBEBERARAREQEQEREBEBERARAREQEQEREBEBERARAREQD
QEREBUBERANAREQFQEREA0BERAVAREQDQEREBEBERAJAREQCQEREA0BERARAREQEQEREBEBERARA
REQEQEREBEBERANAREQEQEREA0BERAVAREQDQEREBUBERANAREQEQEREA0BERARAREQEQEREBEBE
RARAREQEQEREBEBERANAREQEQEREA0BERAVAREQDQEREBUBERANAREQEQEREA0BERARAREQEQERE
BEBERARAREQEQEREBEBERANAREQEQEREA0BERAVAREQDQEREBUBERANAREQEQEREA0BERANAREQC
QEREAkBERAJAREQCQEREA0BERAJAREQDQEREAkBERANAREQBQEREA0BERAJAREQDQEREAkBERANA
REQCQEREAkBERAJAREQCQEREA0BERAJAREQDQEREAkBERANAREQBQEREA0BERAJAREQDQEREAkBE
RANAREQCQEREAkBERAJAREQCQEREA0BERAJAREQDQEREAkBERANAREQBQEREA0BERAJAREQDQERE
AkBERANAREQCQEREAkBERAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAABAAAAAACAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAQAACAAAAAABAAAIAAAAAAEAAAAAAAAAAAAAAAA
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
AABJRU5ErkJggg==')
	#endregion
	$formSeriesOrganizer.KeyPreview = $True
	$formSeriesOrganizer.Name = 'formSeriesOrganizer'
	$formSeriesOrganizer.Text = 'Series Organizer'
	#
	# labelEnterYourSeriesNameB
	#
	$labelEnterYourSeriesNameB.AutoSize = $True
	$labelEnterYourSeriesNameB.Location = '484, 79'
	$labelEnterYourSeriesNameB.Name = 'labelEnterYourSeriesNameB'
	$labelEnterYourSeriesNameB.Size = '161, 17'
	$labelEnterYourSeriesNameB.TabIndex = 20
	$labelEnterYourSeriesNameB.Text = 'Enter Your Series Name Below'
	$labelEnterYourSeriesNameB.UseCompatibleTextRendering = $True
	#
	# buttonSearchIMDB
	#
	$buttonSearchIMDB.Location = '328, 191'
	$buttonSearchIMDB.Name = 'buttonSearchIMDB'
	$buttonSearchIMDB.Size = '139, 71'
	$buttonSearchIMDB.TabIndex = 19
	$buttonSearchIMDB.Text = 'Search IMDB'
	$buttonSearchIMDB.UseCompatibleTextRendering = $True
	$buttonSearchIMDB.UseVisualStyleBackColor = $True
	$buttonSearchIMDB.add_Click($buttonSearchIMDB_Click)
	#
	# SeriesName
	#
	$SeriesName.Location = '484, 99'
	$SeriesName.Name = 'SeriesName'
	$SeriesName.Size = '161, 20'
	$SeriesName.TabIndex = 18
	#
	# label2
	#
	$label2.AutoSize = $True
	$label2.Location = '378, 264'
	$label2.Name = 'label2'
	$label2.Size = '46, 17'
	$label2.TabIndex = 17
	$label2.Text = 'Optional'
	$label2.UseCompatibleTextRendering = $True
	#
	# label1
	#
	$label1.AutoSize = $True
	$label1.Location = '226, 264'
	$label1.Name = 'label1'
	$label1.Size = '46, 17'
	$label1.TabIndex = 16
	$label1.Text = 'Optional'
	$label1.UseCompatibleTextRendering = $True
	#
	# labelOptional
	#
	$labelOptional.AutoSize = $True
	$labelOptional.Location = '76, 264'
	$labelOptional.Name = 'labelOptional'
	$labelOptional.Size = '46, 17'
	$labelOptional.TabIndex = 15
	$labelOptional.Text = 'Optional'
	$labelOptional.UseCompatibleTextRendering = $True
	#
	# buttonCapitalizeFiles
	#
	$buttonCapitalizeFiles.Location = '24, 190'
	$buttonCapitalizeFiles.Name = 'buttonCapitalizeFiles'
	$buttonCapitalizeFiles.Size = '146, 71'
	$buttonCapitalizeFiles.TabIndex = 14
	$buttonCapitalizeFiles.Text = 'Capitalize Files'
	$buttonCapitalizeFiles.UseCompatibleTextRendering = $True
	$buttonCapitalizeFiles.UseVisualStyleBackColor = $True
	$buttonCapitalizeFiles.add_Click($buttonCapitalizeFiles_Click)
	#
	# buttonCreateSeriesFolderAn
	#
	$buttonCreateSeriesFolderAn.Location = '484, 125'
	$buttonCreateSeriesFolderAn.Name = 'buttonCreateSeriesFolderAn'
	$buttonCreateSeriesFolderAn.Size = '161, 136'
	$buttonCreateSeriesFolderAn.TabIndex = 13
	$buttonCreateSeriesFolderAn.Text = 'Create Series Folder And Move Everything in it'
	$buttonCreateSeriesFolderAn.UseCompatibleTextRendering = $True
	$buttonCreateSeriesFolderAn.UseVisualStyleBackColor = $True
	$buttonCreateSeriesFolderAn.add_Click($buttonCreateSeriesFolderAn_Click)
	#
	# buttonCapitalizeFolders
	#
	$buttonCapitalizeFolders.Location = '176, 190'
	$buttonCapitalizeFolders.Name = 'buttonCapitalizeFolders'
	$buttonCapitalizeFolders.Size = '146, 72'
	$buttonCapitalizeFolders.TabIndex = 12
	$buttonCapitalizeFolders.Text = 'Capitalize Folders'
	$buttonCapitalizeFolders.UseCompatibleTextRendering = $True
	$buttonCapitalizeFolders.UseVisualStyleBackColor = $True
	$buttonCapitalizeFolders.add_Click($buttonCapitalizeFolders_Click)
	#
	# buttonBrowseFolder
	#
	$buttonBrowseFolder.Location = '448, 40'
	$buttonBrowseFolder.Name = 'buttonBrowseFolder'
	$buttonBrowseFolder.Size = '30, 23'
	$buttonBrowseFolder.TabIndex = 4
	$buttonBrowseFolder.Text = '...'
	$buttonBrowseFolder.UseCompatibleTextRendering = $True
	$buttonBrowseFolder.UseVisualStyleBackColor = $True
	$buttonBrowseFolder.add_Click($buttonBrowseFolder_Click3)
	#
	# textboxFolder
	#
	$textboxFolder.AutoCompleteMode = 'SuggestAppend'
	$textboxFolder.AutoCompleteSource = 'FileSystemDirectories'
	$textboxFolder.Location = '214, 42'
	$textboxFolder.Name = 'textboxFolder'
	$textboxFolder.Size = '228, 20'
	$textboxFolder.TabIndex = 3
	$textboxFolder.Text = 'Browse Desired Folder to Organize...'
	#
	# button2
	#
	$button2.Location = '214, 296'
	$button2.Name = 'button2'
	$button2.Size = '75, 23'
	$button2.TabIndex = 11
	$button2.Text = 'Website'
	$button2.UseCompatibleTextRendering = $True
	$button2.UseVisualStyleBackColor = $True
	$button2.add_Click($button2_Click)
	#
	# labelThird
	#
	$labelThird.AutoSize = $True
	$labelThird.Location = '378, 169'
	$labelThird.Name = 'labelThird'
	$labelThird.Size = '30, 17'
	$labelThird.TabIndex = 10
	$labelThird.Text = 'Third'
	$labelThird.UseCompatibleTextRendering = $True
	#
	# labelSecond
	#
	$labelSecond.AutoSize = $True
	$labelSecond.Location = '226, 169'
	$labelSecond.Name = 'labelSecond'
	$labelSecond.Size = '43, 17'
	$labelSecond.TabIndex = 9
	$labelSecond.Text = 'Second'
	$labelSecond.UseCompatibleTextRendering = $True
	#
	# labelFirst
	#
	$labelFirst.AutoSize = $True
	$labelFirst.Location = '76, 169'
	$labelFirst.Name = 'labelFirst'
	$labelFirst.Size = '26, 17'
	$labelFirst.TabIndex = 8
	$labelFirst.Text = 'First'
	$labelFirst.UseCompatibleTextRendering = $True
	#
	# labelMadeByAshkanRafiee
	#
	$labelMadeByAshkanRafiee.AutoSize = $True
	$labelMadeByAshkanRafiee.Location = '532, 296'
	$labelMadeByAshkanRafiee.Name = 'labelMadeByAshkanRafiee'
	$labelMadeByAshkanRafiee.Size = '124, 17'
	$labelMadeByAshkanRafiee.TabIndex = 7
	$labelMadeByAshkanRafiee.Text = 'Made by Ashkan Rafiee'
	$labelMadeByAshkanRafiee.UseCompatibleTextRendering = $True
	$labelMadeByAshkanRafiee.add_Click($labelMadeByAshkanRafiee_Click)
	#
	# labelOrganizeYourSeriesAu
	#
	$labelOrganizeYourSeriesAu.AutoSize = $True
	$labelOrganizeYourSeriesAu.Location = '243, 13'
	$labelOrganizeYourSeriesAu.Name = 'labelOrganizeYourSeriesAu'
	$labelOrganizeYourSeriesAu.Size = '186, 17'
	$labelOrganizeYourSeriesAu.TabIndex = 4
	$labelOrganizeYourSeriesAu.Text = 'Organize Your Series Automatically!'
	$labelOrganizeYourSeriesAu.UseCompatibleTextRendering = $True
	#
	# Move_Files
	#
	$Move_Files.Location = '328, 79'
	$Move_Files.Name = 'Move_Files'
	$Move_Files.Size = '139, 87'
	$Move_Files.TabIndex = 3
	$Move_Files.Text = 'Move Files to Folders'
	$Move_Files.UseCompatibleTextRendering = $True
	$Move_Files.UseVisualStyleBackColor = $True
	$Move_Files.add_Click($Move_Files_Click)
	#
	# Create_Folders
	#
	$Create_Folders.Location = '176, 79'
	$Create_Folders.Name = 'Create_Folders'
	$Create_Folders.Size = '146, 87'
	$Create_Folders.TabIndex = 2
	$Create_Folders.Text = 'Create Seasons Folders'
	$Create_Folders.UseCompatibleTextRendering = $True
	$Create_Folders.UseVisualStyleBackColor = $True
	$Create_Folders.add_Click($Create_Folders_Click)
	#
	# Rename
	#
	$Rename.Location = '24, 79'
	$Rename.Name = 'Rename'
	$Rename.Size = '146, 87'
	$Rename.TabIndex = 1
	$Rename.Text = 'Rename Files To SxxExx'
	$Rename.UseCompatibleTextRendering = $True
	$Rename.UseVisualStyleBackColor = $True
	$Rename.add_Click($Rename_Click)
	#
	# buttonWebsite
	#
	$buttonWebsite.Location = '176, 188'
	$buttonWebsite.Name = 'buttonWebsite'
	$buttonWebsite.Size = '75, 23'
	$buttonWebsite.TabIndex = 11
	$buttonWebsite.Text = 'Website'
	$buttonWebsite.UseCompatibleTextRendering = $True
	$buttonWebsite.UseVisualStyleBackColor = $True
	#
	# button1
	#
	$button1.Location = '0, 0'
	$button1.Name = 'button1'
	$button1.Size = '75, 23'
	$button1.TabIndex = 0
	$button1.UseCompatibleTextRendering = $True
	#
	# folderbrowsermoderndialog1
	#
	$formSeriesOrganizer.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $formSeriesOrganizer.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$formSeriesOrganizer.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$formSeriesOrganizer.add_FormClosed($Form_Cleanup_FormClosed)
	#Show the Form
	return $formSeriesOrganizer.ShowDialog()

} #End Function

#Call the form
Show-Organizer_psf | Out-Null
