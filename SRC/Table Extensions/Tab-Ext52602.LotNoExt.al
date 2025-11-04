tableextension 52602 "HMX LotNoExt" extends "Lot No. Information"
{
    fields
    {
        field(50000; "HMX Customer No."; Code[20])
        {
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Customer No.';
            trigger OnValidate()
            var
                Customer_Lrec: Record Customer;
                LotNoInfo_Lrec: Record "Lot No. Information";
            begin
                LotNoInfo_Lrec.Reset();
                LotNoInfo_Lrec.SetRange("Lot No.", Rec."Lot No.");
                LotNoInfo_Lrec.SetFilter("HMX Customer No.", '<>%1&<>%2', '', Rec."HMX Customer No.");
                if not LotNoInfo_Lrec.IsEmpty then
                    Error('This Lot No. is already registered with another customer');
                if Customer_Lrec.Get(Rec."HMX Customer No.") then
                    Rec."HMX CustomerName" := Customer_Lrec.Name;
            end;
        }
        field(50001; "HMX CustomerName"; Text[100])
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the customer name';
            Caption = 'Customer Name';
        }

    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }


}