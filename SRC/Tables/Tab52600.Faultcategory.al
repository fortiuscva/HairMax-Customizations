table 52600 "HMX Fault category"
{
    DataClassification = CustomerContent;
    Caption = 'Fault Category';

    fields
    {
        field(1; Faultcategory; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Fault Category';
            ToolTip = 'Specifies the fault category';
        }
        field(2; Description; Text[250])
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the description for the fault category';
        }
    }

    keys
    {
        key(Key1; Faultcategory)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }



    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}