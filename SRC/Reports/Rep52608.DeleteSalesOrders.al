namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Sales.Document;

report 52608 "HMX Delete Sales Orders"
{
    ApplicationArea = All;
    Caption = 'Delete Sales Orders Prior to Selected Date';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            trigger OnPreDataItem()
            begin
                SetRange("Document Type", "Document Type"::Order);
                SetFilter("Document Date", '..%1', PriorDate);
                DeletedCount := 0;
            end;

            trigger OnAfterGetRecord()
            var
                SalesLine: Record "Sales Line";
            begin
                // Delete related sales lines
                SalesLine.SetRange("Document Type", SalesHeader."Document Type"::Order);
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                if SalesLine.FindSet() then
                    SalesLine.DeleteAll();

                // Delete header
                SalesHeader.Delete();
                DeletedCount += 1;
            end;

            trigger OnPostDataItem()
            begin
                Message('%1 Sales Orders deleted successfully.', DeletedCount);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PriorDate; PriorDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Delete Orders Before Date';
                        ToolTip = 'All sales orders with Document Date before this date will be deleted.';
                    }
                }
            }
        }
    }

    var
        PriorDate: Date;
        DeletedCount: Integer;
}
