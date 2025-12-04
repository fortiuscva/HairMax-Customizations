namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Sales.Document;

report 52607 "Test Duplicate SO for ShpfyOrd"
{
    ApplicationArea = All;
    Caption = 'Test Duplicate SO for ShpfyOrd';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            trigger OnPreDataItem()
            begin
                SalesHeader.Reset();
                SalesHeader.SetRange("No.", SalesOrderNo);
            end;

            trigger OnAfterGetRecord()
            begin
                SalesHeader."Shpfy Order No." := UpdateShpfyOrdNo;
                SalesHeader.Modify(true);
            end;

            trigger OnPostDataItem()
            begin
                Message('Shopify Order No. %1 was updated on Sales Order %2', UpdateShpfyOrdNo, SalesOrderNo);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(OrderDetails)
                {
                    field(SalesOrderNo; SalesOrderNo)
                    {
                        Caption = 'Sales Order No.';
                        ApplicationArea = all;
                    }
                    field(ShpfyOrderNo; UpdateShpfyOrdNo)
                    {
                        Caption = 'Update Shopify Order No.';
                        ApplicationArea = all;
                    }

                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        SalesOrderNo: Code[20];
        UpdateShpfyOrdNo: Code[20];
}
