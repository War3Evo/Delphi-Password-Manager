object DM: TDM
  Height = 350
  Width = 347
  PixelsPerInch = 96
  object FDConnection: TFDConnection
    Params.Strings = (
      'LockingMode=Normal'
      'DriverID=SQLite')
    Connected = True
    LoginDialog = FDGUIxLoginDialog
    LoginPrompt = False
    AfterConnect = FDConnectionAfterConnect
    Left = 56
    Top = 24
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'FMX'
    ScreenCursor = gcrHourGlass
    Left = 56
    Top = 80
  end
  object FDQuEntry: TFDQuery
    OnNewRecord = FDQuEntryNewRecord
    Connection = FDConnection
    UpdateOptions.AssignedValues = [uvCheckReadOnly]
    SQL.Strings = (
      
        'select title, icon, username, password, url, notes, datetimedb f' +
        'rom ENTRY')
    Left = 200
    Top = 16
    object FDQuEntryTitle: TStringField
      DisplayLabel = 'Title'
      FieldName = 'title'
      KeyFields = 'title'
      Origin = 'title'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 254
    end
    object FDQuEntryIcon: TBlobField
      DisplayLabel = 'Icon'
      FieldName = 'icon'
      KeyFields = 'icon'
      Origin = 'icon'
    end
    object FDQuEntryUserN: TStringField
      DisplayLabel = 'Username'
      FieldName = 'username'
      KeyFields = 'username'
      Origin = 'username'
      Size = 254
    end
    object FDQuEntryPassw: TStringField
      DisplayLabel = 'Password'
      FieldName = 'password'
      KeyFields = 'password'
      Origin = 'password'
      Required = True
      FixedChar = True
      Size = 64
    end
    object FDQuEntryDateC: TDateField
      DisplayLabel = 'Date created'
      FieldName = 'datetimedb'
      KeyFields = 'datetimedb'
      Origin = 'datetimedb'
    end
    object FDQuEntryMemoURL: TMemoField
      DisplayLabel = 'URL'
      FieldName = 'url'
      KeyFields = 'url'
      Origin = 'url'
      BlobType = ftMemo
      Size = 65535
    end
    object FDQuEntryMemoNotes: TMemoField
      DisplayLabel = 'Notes'
      FieldName = 'notes'
      KeyFields = 'notes'
      Origin = 'notes'
      BlobType = ftMemo
      Size = 65535
    end
  end
  object dsEntry: TDataSource
    AutoEdit = False
    DataSet = FDQuEntry
    Left = 264
    Top = 16
  end
  object FDSQLiteSecurity: TFDSQLiteSecurity
    DriverLink = FDPhysSQLiteDriverLink
    Options = [soSetLargeCache]
    Left = 56
    Top = 192
  end
  object FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink
    Left = 56
    Top = 248
  end
  object FDGUIxLoginDialog: TFDGUIxLoginDialog
    Provider = 'FMX'
    Left = 56
    Top = 136
  end
  object FDQuEntryDelete: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'delete from ENTRY where id = :id ')
    Left = 200
    Top = 72
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end>
  end
  object Lang: TLang
    Lang = 'en'
    Left = 200
    Top = 168
    ResourcesBin = {
      EF02000045006E00740065007200200079006F007500720020006C006F006700
      69006E00200069006E0066006F0072006D006100740069006F006E000D000A00
      4F004B000D000A00430061006E00630065006C000D000A005000610073007300
      77006F00720064000D000A00430068006F006F00730065002000610020006D00
      610073007400650072002000700061007300730077006F007200640020007400
      6F002000700072006F007400650063007400200079006F007500720020006400
      61007400610062006100730065003A000D000A005100750065006C006C006500
      0D000A004C006900730074000D000A004100640064000D000A00540069007400
      6C0065000D000A00490063006F006E000D000A0055007300650072006E006100
      6D0065000D000A00550052004C000D000A004E006F007400650073000D000A00
      4400610074006500200063007200650061007400650064000D000A0053006500
      7400740069006E00670073000D000A0049006E0066006F000D000A0044006500
      760065006C006F0070006D0065006E007400200045006E007600690072006F00
      6E006D0065006E0074000D000A005400690074006C0065003A000D000A004300
      6F006D00700061006E0079003A000D000A005700650062003A000D000A004400
      6500760065006C006F007000650072003A000D000A00530051004C0069007400
      6500200045006E00630072007900700074006500640020004400610074006100
      62006100730065000D000A0054006800650020004100450053002D0032003500
      36002000700072006F0076006900640065007300200074006F00700020007300
      740072006F006E006700200043006F006E0066006900640065006E0074006900
      61006C00690074007900200061006E006400200049006E007400650067007200
      6900740079002E000D000A00560065007200730069006F006E003A000D000A00
      4300680061007200610063007400650072002000730065006C00650063007400
      69006F006E000D000A004C006F00770065007200630061007300650020006C00
      6500740074006500720073002000280061002D007A0029000D000A0055007000
      700065007200630061007300650020006C006500740074006500720073002000
      280041002D005A0029000D000A004E0075006D00620065007200730020002800
      30002D00390029000D000A005300700065006300690061006C00200063006800
      610072006100630074006500720073000D000A00500061007300730077006F00
      7200640020006C0065006E006700740068000D000A0041006300630065007000
      74000D000A00470065006E00650072006100740065000D000A00470065006E00
      6500720061007400650064002000700061007300730077006F00720064000D00
      0A0045006E006300720079007000740069006F006E0020007300740061007400
      750073003A000D000A005300740061007400750073000D000A00430068006100
      6E006700650020006D0061007300740065007200200070006100730073007700
      6F00720064000D000A004300680061006E00670065000D000A00430075007200
      720065006E0074002000700061007300730077006F00720064000D000A004E00
      650077002000700061007300730077006F00720064000D000A00410063007400
      750061006C0020004400720069007600650072002000490044003A000D000A00
      440072006900760065007200490044000D000A00440061007400610062006100
      730065003A000D000A00440061007400610062006100730065000D000A004C00
      610073007400200075007300650064003A000D000A0044006100740065000D00
      0A00440061007400610062006100730065002000730069007A0065003A000D00
      0A00530069007A0065000D000A0049004A005000200050006100730073007700
      6F007200640020004D0061006E0061006700650072000D000A00410064006400
      200065006E007400720079000D000A004500640069007400200065006E007400
      720079000D000A002700410064006400200065006E0074007200790027000D00
      0A00020000000200000064006500F306000045006E0074006500720020007900
      6F007500720020006C006F00670069006E00200069006E0066006F0072006D00
      6100740069006F006E003D0047006500620065006E0020005300690065002000
      4900680072006500200041006E006D0065006C006400650069006E0066006F00
      72006D006100740069006F006E0065006E002000650069006E000D000A004F00
      4B003D004F004B000D000A00430061006E00630065006C003D00410062006200
      720065006300680065006E000D000A00500061007300730077006F0072006400
      3D00500061007300730077006F00720074000D000A00430068006F006F007300
      65002000610020006D0061007300740065007200200070006100730073007700
      6F0072006400200074006F002000700072006F00740065006300740020007900
      6F00750072002000640061007400610062006100730065003A003D005700E400
      68006C0065002000650069006E0020004D00610073007400650072002D005000
      61007300730077006F00720074002C0020006D00690074002000640065006D00
      20006400650069006E006500200044006100740065006E00620061006E006B00
      200067006500730063006800FC0074007A007400200077006900720064003A00
      0D000A005100750065006C006C0065003D005100750065006C006C0065000D00
      0A004C006900730074003D004C0069007300740065000D000A00410064006400
      3D00480069006E007A0075006600FC00670065006E000D000A00540069007400
      6C0065003D004E0061006D0065000D000A00490063006F006E003D0049006300
      6F006E000D000A0055007300650072006E0061006D0065003D00420065006E00
      750074007A00650072000D000A00550052004C003D00550052004C000D000A00
      4E006F007400650073003D004B006F006D006D0065006E007400610072006500
      0D000A004400610074006500200063007200650061007400650064003D004400
      6100740075006D002000650072007300740065006C006C0074000D000A005300
      65007400740069006E00670073003D00450069006E007300740065006C006C00
      75006E00670065006E000D000A0049006E0066006F003D0049006E0066006F00
      0D000A0049004A0050002000500061007300730077006F007200640020004D00
      61006E0061006700650072003D0049004A005000200050006100730073007700
      6F007200640020004D0061006E0061006700650072000D000A00440065007600
      65006C006F0070006D0065006E007400200045006E007600690072006F006E00
      6D0065006E0074003D0045006E0074007700690063006B006C0075006E006700
      730075006D0067006500620075006E0067000D000A005400690074006C006500
      3A003D0054006900740065006C003A000D000A00440065006C00700068006900
      2000310030002E00310020004200650072006C0069006E003D00440065006C00
      7000680069002000310030002E00310020004200650072006C0069006E000D00
      0A0043006F006D00700061006E0079003A003D0055006E007400650072006E00
      650068006D0065006E003A000D000A0045006D00620061007200630061006400
      650072006F00200054006500630068006E006F006C006F006700690065007300
      3D0045006D00620061007200630061006400650072006F002000540065006300
      68006E006F006C006F0067006900650073000D000A005700650062003A003D00
      5700650062003A000D000A0068007400740070003A002F002F0065006D006200
      61007200630061006400650072006F002E0063006F006D003D00680074007400
      70003A002F002F0065006D00620061007200630061006400650072006F002E00
      63006F006D000D000A0044006500760065006C006F007000650072003A003D00
      45006E0074007700690063006B006C00650072003A000D000A00490074006100
      72006300690020004A006F007300E900200050006F007300730061006D006100
      69003D0049007400610072006300690020004A006F007300E900200050006F00
      7300730061006D00610069000D000A00530051004C0069007400650020004500
      6E00630072007900700074006500640020004400610074006100620061007300
      65003D005600650072007300630068006C00FC007300730065006C0074006500
      2000530051004C006900740065002D0044006100740065006E00620061006E00
      6B0065006E000D000A004100450053002D003200350036003A003D0041004500
      53002D003200350036003A000D000A0054006800650020004100450053002D00
      3200350036002000700072006F0076006900640065007300200074006F007000
      20007300740072006F006E006700200043006F006E0066006900640065006E00
      7400690061006C00690074007900200061006E006400200049006E0074006500
      670072006900740079002E003D0044006500720020004100450053002D003200
      350036002D0041006C0067006F0072006900740068006D007500730020007300
      740065006C006C0074002000650069006E00650020006F007000740069006D00
      61006C006500200056006500720074007200610075006C006900630068006B00
      650069007400200075006E006400200049006E00740065006700720069007400
      E400740020006200650072006500690074002E000D000A005600650072007300
      69006F006E003A003D00560065007200730069006F006E003A000D000A004300
      680061007200610063007400650072002000730065006C006500630074006900
      6F006E003D00430068006100720061006B007400650072002D00410075007300
      7700610068006C000D000A004C006F0077006500720063006100730065002000
      6C006500740074006500720073002000280061002D007A0029003D004B006C00
      650069006E006200750063006800730074006100620065006E00200028006100
      2D007A0029000D000A0055007000700065007200630061007300650020006C00
      6500740074006500720073002000280041002D005A0029003D00470072006F00
      DF006200750063006800730074006100620065006E002000280041002D005A00
      29000D000A004E0075006D0062006500720073002000280030002D0039002900
      3D005A00610068006C0065006E002000280030002D00390029000D000A005300
      700065006300690061006C002000630068006100720061006300740065007200
      73003D0053006F006E006400650072007A00650069006300680065006E000D00
      0A00500061007300730077006F007200640020006C0065006E00670074006800
      3D00500061007300730077006F00720074006C00E4006E00670065000D000A00
      4100630063006500700074003D0041006B007A00650070007400690065007200
      65006E000D000A00470065006E00650072006100740065006400200070006100
      7300730077006F00720064003D00470065006E00650072006900650072007400
      6500730020004B0065006E006E0077006F00720074000D000A00470065006E00
      650072006100740065003D00470065006E006500720069006500720065006E00
      0D000A0045006E006300720079007000740069006F006E002000730074006100
      7400750073003A003D005600650072007300630068006C00FC00730073006500
      6C0075006E00670073007300740061007400750073003A000D000A0053007400
      61007400750073003D005300740061007400750073000D000A00430068006100
      6E006700650020006D0061007300740065007200200070006100730073007700
      6F00720064003D00C4006E006400650072006E00200064006500730020004D00
      610073007400650072002D004B0065006E006E0077006F007200740073000D00
      0A004300680061006E00670065003D00C4006E006400650072006E000D000A00
      430075007200720065006E0074002000700061007300730077006F0072006400
      3D0041006B007400750065006C006C0065007300200050006100730073007700
      6F00720074000D000A004E00650077002000700061007300730077006F007200
      64003D004E0065007500650073002000500061007300730077006F0072007400
      0D000A00410063007400750061006C0020004400720069007600650072002000
      490044003A003D0041006B007400750065006C006C0065002000540072006500
      69006200650072002000490044003A000D000A00440072006900760065007200
      490044003D005400720065006900620065007200490044000D000A0044006100
      7400610062006100730065003A003D0044006100740065006E00620061006E00
      6B003A000D000A00440061007400610062006100730065003D00440061007400
      65006E00620061006E006B000D000A004C006100730074002000750073006500
      64003A003D005A0075006C00650074007A007400200076006500720077006500
      6E006400650074003A000D000A0044006100740065003D004400610074007500
      6D000D000A00440061007400610062006100730065002000730069007A006500
      3A003D0044006100740065006E00620061006E006B0067007200F600DF006500
      3A000D000A00530069007A0065003D0047007200F600DF0065000D000A004100
      64006400200065006E007400720079003D00450069006E007400720061006700
      2000680069006E007A0075006600FC00670065006E000D000A00450064006900
      7400200065006E007400720079003D00450069006E0074007200610067002000
      6200650061007200620065006900740065006E000D000A002700410064006400
      200065006E0074007200790027003D00450069006E0074007200610067002000
      680069006E007A0075006600FC00670065006E000D000A000200000070006F00
      B406000045006E00740065007200200079006F007500720020006C006F006700
      69006E00200069006E0066006F0072006D006100740069006F006E003D004900
      6E0066006F0072006D00650020007300750061007300200069006E0066006F00
      72006D006100E700F5006500730020006400650020006C006F00670069006E00
      0D000A004F004B003D004F004B000D000A00430061006E00630065006C003D00
      430061006E00630065006C00610072000D000A00500061007300730077006F00
      720064003D00530065006E00680061000D000A00430068006F006F0073006500
      2000610020006D00610073007400650072002000700061007300730077006F00
      72006400200074006F002000700072006F007400650063007400200079006F00
      750072002000640061007400610062006100730065003A003D00530065006C00
      6500630069006F006E006500200075006D0061002000730065006E0068006100
      20006D00650073007400720065000D000A005100750065006C006C0065003D00
      46006F006E00740065000D000A004C006900730074003D004C00690073007400
      61000D000A004100640064003D00410064006900630069006F006E0061007200
      0D000A005400690074006C0065003D004E006F006D0065000D000A0049006300
      6F006E003D00CD0063006F006E0065000D000A0055007300650072006E006100
      6D0065003D004E006F006D0065002000640065002000750073007500E1007200
      69006F000D000A00550052004C003D00550052004C000D000A004E006F007400
      650073003D0043006F006D0065006E007400E100720069006F0073000D000A00
      4400610074006500200063007200650061007400650064003D00440061007400
      61002000630072006900610064006F000D000A00530065007400740069006E00
      670073003D0043006F006E00660069006700750072006100E700F50065007300
      0D000A0049006E0066006F003D0049006E0066006F0072006D006100E700F500
      650073000D000A0049004A0050002000500061007300730077006F0072006400
      20004D0061006E0061006700650072003D0049004A0050002000500061007300
      730077006F007200640020004D0061006E0061006700650072000D000A004400
      6500760065006C006F0070006D0065006E007400200045006E00760069007200
      6F006E006D0065006E0074003D004C0069006E00670075006100670065006D00
      200064006500200064006500730065006E0076006F006C00760069006D006500
      6E0074006F000D000A005400690074006C0065003A003D004E006F006D006500
      0D000A00440065006C007000680069002000310030002E003100200042006500
      72006C0069006E003D00440065006C007000680069002000310030002E003100
      20004200650072006C0069006E000D000A0043006F006D00700061006E007900
      3A003D0043006F006D00700061006E006800690061003A000D000A0045006D00
      620061007200630061006400650072006F00200054006500630068006E006F00
      6C006F0067006900650073003D0045006D006200610072006300610064006500
      72006F00200054006500630068006E006F006C006F0067006900650073000D00
      0A005700650062003A003D005700650062003A000D000A006800740074007000
      3A002F002F0065006D00620061007200630061006400650072006F002E006300
      6F006D003D0068007400740070003A002F002F0065006D006200610072006300
      61006400650072006F002E0063006F006D000D000A0044006500760065006C00
      6F007000650072003A003D0044006500730065006E0076006F006C0076006500
      64006F0072003A000D000A0049007400610072006300690020004A006F007300
      E900200050006F007300730061006D00610069003D0049007400610072006300
      690020004A006F007300E900200050006F007300730061006D00610069000D00
      0A00530051004C00690074006500200045006E00630072007900700074006500
      64002000440061007400610062006100730065003D00420061006E0063006F00
      20006400650020006400610064006F007300200065006E006300720069007000
      74006F006700720061006600610064006F002000530051004C00690074006500
      0D000A004100450053002D003200350036003A003D004100450053002D003200
      350036003A000D000A0054006800650020004100450053002D00320035003600
      2000700072006F0076006900640065007300200074006F007000200073007400
      72006F006E006700200043006F006E0066006900640065006E00740069006100
      6C00690074007900200061006E006400200049006E0074006500670072006900
      740079002E003D00410020004100450053002D00320035003600200066006F00
      72006E00650063006500200063006F006E0066006900640065006E0063006900
      61006C0069006400610064006500200066006F00720074006500200065002000
      49006E007400650067007200690064006100640065002E000D000A0056006500
      7200730069006F006E003A003D005600650072007300E3006F003A000D000A00
      4300680061007200610063007400650072002000730065006C00650063007400
      69006F006E003D00530065006C006500E700E3006F0020006400650020006300
      6100720061006300740065007200650073000D000A004C006F00770065007200
      630061007300650020006C006500740074006500720073002000280061002D00
      7A0029003D004C006500740072006100730020006D0069006E00FA0073006300
      75006C00610073002000280061002D007A0029000D000A005500700070006500
      7200630061007300650020006C00650074007400650072007300200028004100
      2D005A0029003D004C006500740072006100730020006D006100ED0075007300
      630075006C00610073002000280041002D005A0029000D000A004E0075006D00
      62006500720073002000280030002D00390029003D004E00FA006D0065007200
      6F0073002000280030002D00390029000D000A00530070006500630069006100
      6C00200063006800610072006100630074006500720073003D00430061007200
      6100630074006500720065007300200065007300700065006300690061006900
      73000D000A00500061007300730077006F007200640020006C0065006E006700
      740068003D00540061006D0061006E0068006F00200064006100200073006500
      6E00680061000D000A004100630063006500700074003D004100630065006900
      7400610072000D000A00470065006E0065007200610074006500640020007000
      61007300730077006F00720064003D00530065006E0068006100200067006500
      72006100640061000D000A00470065006E00650072006100740065003D004700
      65007200610072000D000A0045006E006300720079007000740069006F006E00
      20007300740061007400750073003A003D005300740061007400750073002000
      64006100200065006E00630072006900700074006100E700E3006F000D000A00
      5300740061007400750073003D005300740061007400750073000D000A004300
      680061006E006700650020006D00610073007400650072002000700061007300
      730077006F00720064003D0041006C0074006500720061007200200073006500
      6E006800610020006D00650073007400720065000D000A004300680061006E00
      670065003D0041006C00740065007200610072000D000A004300750072007200
      65006E0074002000700061007300730077006F00720064003D00530065006E00
      68006100200061007400750061006C000D000A004E0065007700200070006100
      7300730077006F00720064003D004E006F00760061002000730065006E006800
      61000D000A00410063007400750061006C002000440072006900760065007200
      2000490044003A003D0044007200690076006500720020004900440020006100
      7400750061006C003A000D000A00440072006900760065007200490044003D00
      440072006900760065007200490044000D000A00440061007400610062006100
      730065003A003D00420061006E0063006F002000640065002000640061006400
      6F0073003A000D000A00440061007400610062006100730065003D0042006100
      6E0063006F0020006400650020006400610064006F0073000D000A004C006100
      73007400200075007300650064003A003D00DA006C00740069006D0061002000
      7500740069006C0069007A006100E700E3006F000D000A004400610074006500
      3D0044006100740061000D000A00440061007400610062006100730065002000
      730069007A0065003A003D00540061006D0061006E0068006F00200064006F00
      2000620061006E0064006F0020006400650020006400610064006F0073000D00
      0A00530069007A0065003D00540061006D0061006E0068006F000D000A004100
      64006400200065006E007400720079003D00410064006900630069006F006E00
      61007200200065006E00740072006100640061000D000A004500640069007400
      200065006E007400720079003D00450064006900740061007200200065006E00
      740072006100640061000D000A002700410064006400200065006E0074007200
      790027003D00410064006900630069006F006E0061007200200065006E007400
      72006100640061000D000A00}
  end
  object FDQueryImportAdd: TFDQuery
    Connection = FDConnection
    Left = 200
    Top = 240
  end
end
