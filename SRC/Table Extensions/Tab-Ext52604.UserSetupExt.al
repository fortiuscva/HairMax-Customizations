tableextension 52604 "HMX UserSetupExt" extends "User Setup"
{
    fields
    {
        field(52600; "HMX CaseMangement"; Boolean)
        {
            Caption = 'Case Mangement List Permissions';
            DataClassification = CustomerContent;
        }
        field(52601; "HMX Edit Cust. Post. Group"; Boolean)
        {
            Caption = 'Edit Customer Posting Group';
            DataClassification = ToBeClassified;
        }
    }
}
