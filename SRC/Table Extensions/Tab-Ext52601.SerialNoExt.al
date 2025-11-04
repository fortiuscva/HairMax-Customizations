tableextension 52601 "HMX SerialNoExt" extends "Serial No. Information"
{
    fields
    {
        field(50000; "HMX Customer No."; Code[20])
        {
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Customer No.';
            Caption = 'Customer No.';
            trigger OnValidate()
            var
                Customer_Lrec: Record Customer;
                SerialNoInfo_Lrec: Record "Serial No. Information";
            begin
                if Rec."HMX Customer No." = '' then
                    exit;
                SerialNoInfo_Lrec.Reset();
                SerialNoInfo_Lrec.SetRange("Serial No.", Rec."Serial No.");
                SerialNoInfo_Lrec.SetRange("HMX Customer No.", Rec."HMX Customer No.");
                if not SerialNoInfo_Lrec.IsEmpty then
                    Message('This Serial No. is already registered with another customer');
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
        field(50002; "HMX Reseller"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Reseller';
            ToolTip = 'Specifies the reseller details';

        }
        field(50003; "HMX Extended Protection"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Extended Protection Plan';
            ToolTip = 'Specifies the exteneded protection plan';
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