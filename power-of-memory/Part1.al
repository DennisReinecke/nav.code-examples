report 50001 "PART1 Report"
{
    // version NAVW111.00
    // Report 109 - Customer - Summary Aging Simp.
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Customer - Summary Aging Simp..rdlc';
    Caption = 'PART1 Report - Customer - Summary Aging Simp.';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.","Search Name","Customer Posting Group","Statistics Group","Payment Terms Code";
            column(STRSUBSTNO_Text001_FORMAT_StartDate__;STRSUBSTNO(Text001,FORMAT(StartDate)))
            {
            }
            column(CurrReport_PAGENO;CurrReport.PAGENO)
            {
            }
            column(COMPANYNAME;COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(Customer_TABLECAPTION__________CustFilter;TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(CustFilter;CustFilter)
            {
            }
            column(CustBalanceDueLCY_5_;CustBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4_;CustBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3_;CustBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2_;CustBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_1_;CustBalanceDueLCY[1])
            {
                AutoFormatType = 1;
            }
            column(Customer__No__;"No.")
            {
            }
            column(Customer_Name;Name)
            {
            }
            column(CustBalanceDueLCY_5__Control25;CustBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4__Control26;CustBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3__Control27;CustBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2__Control28;CustBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_1__Control29;CustBalanceDueLCY[1])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_5__Control37;CustBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4__Control38;CustBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3__Control39;CustBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2__Control40;CustBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_1__Control41;CustBalanceDueLCY[1])
            {
                AutoFormatType = 1;
            }
            column(Customer___Summary_Aging_Simp_Caption;Customer___Summary_Aging_Simp_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption;All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(Customer__No__Caption;FIELDCAPTION("No."))
            {
            }
            column(Customer_NameCaption;FIELDCAPTION(Name))
            {
            }
            column(CustBalanceDueLCY_5__Control25Caption;CustBalanceDueLCY_5__Control25CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_4__Control26Caption;CustBalanceDueLCY_4__Control26CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_3__Control27Caption;CustBalanceDueLCY_3__Control27CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_2__Control28Caption;CustBalanceDueLCY_2__Control28CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_1__Control29Caption;CustBalanceDueLCY_1__Control29CaptionLbl)
            {
            }
            column(TotalCaption;TotalCaptionLbl)
            {
            }


            trigger OnPreDataItem()
            var
                DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                CustomerPeriodList: Dictionary of [Integer, Decimal];
                Period: Integer;
                CumulatedAmount: Decimal;
            begin
                    
                if not DtldCustLedgEntry.FindSet(false, false) then
                    exit;
                    
                repeat
                    Period := GetPeriodFromDate(DtldCustLedgEntry."Posting Date");
                    CumulatedAmount := 0;
                    Clear(CustomerPeriodList);
                    if CustomerAmountList.Get(DtldCustLedgEntry."Customer No.", CustomerPeriodList) then
                        if CustomerPeriodList.Get(Period, CumulatedAmount) then ;

                    CustomerPeriodList.Set(Period, CumulatedAmount + DtldCustLedgEntry."Amount (LCY)");
                    CustomerAmountList.Set(DtldCustLedgEntry."Customer No.", CustomerPeriodList);
                until DtldCustLedgEntry.Next() = 0;
            end;


            trigger OnAfterGetRecord()
            var
                CustomerPeriodList: Dictionary of [Integer, Decimal];
                PrintCust: Boolean;
                i: Integer;
            begin
                if not CustomerAmountList.Get(Customer."No.", CustomerPeriodList) then 
                    CurrReport.Skip(); // Customer does not have any postings

                PrintCust := false;
                for i := 1 to 5 do begin
                    CustBalanceDueLCY[i] := 0;
                    if CustomerPeriodList.Get(i, CustBalanceDueLCY[i]) then
                        if CustBalanceDueLCY[i] <> 0 then
                            PrintCust := true;
                end;

                if not PrintCust then
                    CurrReport.Skip();
            end;

        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StartingDate;StartDate)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Starting Date';
                        ToolTip = 'Specifies the date from which the report or batch job processes information.';
                    }
                }
            }
        }

        trigger OnOpenPage();
        begin
            IF StartDate = 0D THEN
              StartDate := WORKDATE;
        end;
    }

    trigger OnPreReport();
    var
        CaptionManagement : Codeunit CaptionManagement;
    begin
        CustFilter := CaptionManagement.GetRecordFiltersWithCaptions(Customer);
        PeriodStartDate[5] := StartDate;
        PeriodStartDate[6] := DMY2DATE(31,12,9999);
        FOR i := 4 DOWNTO 2 DO
          PeriodStartDate[i] := CALCDATE('<-30D>',PeriodStartDate[i + 1]);
    end;

    var
        Text001 : Label 'As of %1';
        DtldCustLedgEntry : Record "Detailed Cust. Ledg. Entry";
        CustomerAmountList: Dictionary of [Code[20], Dictionary of [Integer, Decimal]];
        StartDate : Date;
        CustFilter : Text;
        PeriodStartDate : array [6] of Date;
        CustBalanceDueLCY : array [5] of Decimal;
        PrintCust : Boolean;
        i : Integer;
        Customer___Summary_Aging_Simp_CaptionLbl : Label 'Customer - Summary Aging Simp.';
        CurrReport_PAGENOCaptionLbl : Label 'Page';
        All_amounts_are_in_LCYCaptionLbl : Label 'All amounts are in LCY';
        CustBalanceDueLCY_5__Control25CaptionLbl : Label 'Not Due';
        CustBalanceDueLCY_4__Control26CaptionLbl : Label '0-30 days';
        CustBalanceDueLCY_3__Control27CaptionLbl : Label '31-60 days';
        CustBalanceDueLCY_2__Control28CaptionLbl : Label '61-90 days';
        CustBalanceDueLCY_1__Control29CaptionLbl : Label 'Over 90 days';
        TotalCaptionLbl : Label 'Total';

    procedure InitializeRequest(StartingDate : Date);
    begin
        StartDate := StartingDate;
    end;

    
    local procedure GetPeriodFromDate(DateToCheck: Date) : Integer
    var
        i: Integer;
    begin
        for i := 1 to 5 do
            if (PeriodStartDate[i] <= DateToCheck) and ((PeriodStartDate[i + 1] - 1) >= DateToCheck) then
                exit(i);
    end;
}
