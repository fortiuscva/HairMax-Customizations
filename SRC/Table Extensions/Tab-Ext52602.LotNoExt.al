tableextension 52602 "HMX LotNoExt" extends "Lot No. Information"
{
    fields
    {
        field(50000; "HMX Customer No."; Code[20])
        {
            TableRelation = Customer."No.";
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Customer No.';
            trigger OnValidate()
            var
                Customer_Lrec: Record Customer;
                LotNoInfo_Lrec: Record "Lot No. Information";
            begin
                if Rec."HMX Customer No." = '' then
                    exit;
                LotNoInfo_Lrec.Reset();
                LotNoInfo_Lrec.SetRange("Lot No.", Rec."Lot No.");
                LotNoInfo_Lrec.SetRange("HMX Customer No.", Rec."HMX Customer No.");
                if not LotNoInfo_Lrec.IsEmpty then
                    Message('This Lot No. is already registered with another customer');
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