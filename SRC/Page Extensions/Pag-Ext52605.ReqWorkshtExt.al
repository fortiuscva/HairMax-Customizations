pageextension 52605 "HMX ReqWorkshtExt" extends "Req. Worksheet"
{
    layout
    {
        addafter("Vendor No.")
        {
            field("HMX BuyFromVendorName1"; GetVendorName())
            {
                Caption = 'Vendor Name';
                ApplicationArea = all;
            }
        }

    }



    procedure GetVendorName(): Text[250]
    var
        myInt: Integer;
    begin
        ReqJnlManagement.GetDescriptionAndRcptName(Rec, Description2, BuyFromVendorName1);
        exit(BuyFromVendorName1);
    end;

    var
        BuyFromVendorName1: Text[250];
        ReqJnlManagement: Codeunit ReqJnlManagement;
}
