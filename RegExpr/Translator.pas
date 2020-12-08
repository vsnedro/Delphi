unit Translator;

interface

uses
  System.Generics.Collections;

type
  /// <summary>
  /// Translator interface
  /// </summary>
  ITranslator = interface
    ['{4BAAF315-D3BC-4FFA-A36C-EFA6529848A7}']
    function GetValue(
      const AKey     : Integer;
      const ADefault : String = '') : String;
  end;

type
  /// <summary>
  /// Translator class
  /// </summary>
  TTranslator = class(TInterfacedObject, ITranslator)
  private
  const
    CDictFileName = 'translation.dic';
  private
    FDictionary : TDictionary<Integer, String>;
  private
    {$REGION ' ITranslator '}
    function GetValue(
      const AKey     : Integer;
      const ADefault : String = '') : String;
    {$ENDREGION}
  public
    /// <summary> Constructor </summary>
    constructor Create(
      const ADictFileName : String = CDictFileName);
    /// <summary> Destructor </summary>
    destructor Destroy(); override;
  end;

implementation

uses
  System.Classes,
  System.IniFiles,
  System.SysUtils;

{------------------------------------------------------------------------------}
{ TTranslator }
{------------------------------------------------------------------------------}

/// <summary> Constructor </summary>
constructor TTranslator.Create(
  const ADictFileName : String = CDictFileName);
begin
  inherited Create();

  FDictionary := TDictionary<Integer, String>.Create();

  if FileExists(ADictFileName) then
  begin
    var f := TMemIniFile.Create(ADictFileName);
    try
      var strings := TStringList.Create();
      try
        var section := System.SysUtils.SysLocale.DefaultLCID.ToString();
        f.ReadSectionValues(section, strings);
        for var i := 0 to strings.Count - 1 do
        begin
          var key := StrToIntDef(strings.KeyNames[i], -1);
          if (key > 0) then
            FDictionary.TryAdd(key, strings.ValueFromIndex[i]);
        end;
      finally
        FreeAndNil(strings);
      end;
    finally
      FreeAndNil(f);
    end;
  end;
end;

/// <summary> Destructor </summary>
destructor TTranslator.Destroy();
begin
  FreeAndNil(FDictionary);

  inherited Destroy();
end;

{$REGION ' ITranslator '}
function TTranslator.GetValue(
  const AKey     : Integer;
  const ADefault : String = '') : String;
begin
  if not FDictionary.TryGetValue(AKey, {out}Result) then
    Result := ADefault;
end;
{$ENDREGION}

end.
