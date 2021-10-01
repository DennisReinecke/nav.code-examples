codeunit 50000 "JSON Helper"
{

    procedure GetValueAsText(Path: Text; JToken: JsonToken) ReturnValue: Text
    var
        SelectToken: JsonToken;
    begin
        if JToken.SelectToken(Path, SelectToken) then
            if not SelectToken.AsValue().IsNull() then
                ReturnValue := SelectToken.AsValue().AsText().Replace('\"', '"');
    end;

    procedure GetValueAsBoolean(Path: Text; JToken: JsonToken) ReturnValue: Boolean
    var
        SelectToken: JsonToken;
    begin
        if JToken.SelectToken(Path, SelectToken) then
            if not SelectToken.AsValue().IsNull() then
                ReturnValue := SelectToken.AsValue().AsBoolean()
    end;

    procedure GetValueAsInt(Path: Text; JToken: JsonToken) ReturnValue: Integer
    var
        SelectToken: JsonToken;
    begin
        if JToken.SelectToken(Path, SelectToken) then
            if not SelectToken.AsValue().IsNull() then
                ReturnValue := SelectToken.AsValue().AsInteger()
    end;

    procedure GetValueAsDecimal(Path: Text; JToken: JsonToken) ReturnValue: Decimal
    var
        SelectToken: JsonToken;
    begin
        if JToken.SelectToken(Path, SelectToken) then
            if not SelectToken.AsValue().IsNull() then
                ReturnValue := SelectToken.AsValue().AsDecimal()
    end;

    procedure GetValueAsDate(Path: Text; JToken: JsonToken) ReturnValue: Date
    var
        SelectToken: JsonToken;
    begin
        if JToken.SelectToken(Path, SelectToken) then
            if not SelectToken.AsValue().IsNull() then
                if not (GetValueAsText(Path, JToken) = '') then
                    ReturnValue := SelectToken.AsValue().AsDate()
    end;

    procedure GetValueAsDateTime(Path: Text; JToken: JsonToken) ReturnValue: DateTime
    var
        SelectToken: JsonToken;
    begin
        if JToken.SelectToken(Path, SelectToken) then
            if not SelectToken.AsValue().IsNull() then
                if not (GetValueAsText(Path, JToken) = '') then
                    ReturnValue := SelectToken.AsValue().AsDateTime()
    end;

    procedure GetValueAsTime(Path: Text; JToken: JsonToken) ReturnValue: Time
    var
        SelectToken: JsonToken;
    begin
        if JToken.SelectToken(Path, SelectToken) then
            if not SelectToken.AsValue().IsNull() then
                if not (GetValueAsText(Path, JToken) = '') then
                    ReturnValue := SelectToken.AsValue().AsTime()
    end;
}