table 52606 "HMX Cycle Count Log"
{
    Caption = 'Cycle Count Log';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }

        field(2; "Count Date"; Date)
        {
            Caption = 'Count Date';

            trigger OnValidate()
            begin
                UpdateSessionID();
            end;
        }

        field(3; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location.Code;

            trigger OnValidate()
            begin
                UpdateSessionID();
                UpdateBCQuantity();
                UpdateAccuracy();
            end;
        }

        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                UpdateBCQuantity();
                UpdateAccuracy();
            end;
        }

        field(5; "BC Qty"; Decimal)
        {
            Caption = 'On Hand Qty';
            Editable = false;
            DecimalPlaces = 0 : 5;
        }

        field(6; "Count Qty"; Decimal)
        {
            Caption = 'Count Qty';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                "Count Entered" := true;
                UpdateAccuracy();
            end;
        }

        // Existing field reused to store Accuracy %.
        field(7; Variance; Decimal)
        {
            Caption = 'Accuracy %';
            Editable = false;
            DecimalPlaces = 0 : 2;
        }

        // Retained because this field was previously published.
        field(8; Comments; Text[250])
        {
            Caption = 'Comments';
        }

        field(9; "Counted By"; Text[100])
        {
            Caption = 'Logged By';
            Editable = false;
        }

        field(10; "Completed Date Time"; DateTime)
        {
            Caption = 'Logged Date/Time';
            Editable = false;
        }

        field(11; Status; Option)
        {
            Caption = 'Status';

            // Keep internal values unchanged for schema compatibility.
            OptionMembers = Open,Completed;

            // Display Completed as Logged.
            OptionCaption = 'Open,Logged';

            InitValue = Open;
            Editable = false;
        }

        field(12; "Count Session ID"; Code[30])
        {
            Caption = 'Count Session ID';
            Editable = false;
        }

        field(13; "Count Entered"; Boolean)
        {
            Caption = 'Count Entered';
            Editable = false;
        }

        // Retained because these fields were previously published.
        field(14; "Correction Of Entry No."; Integer)
        {
            Caption = 'Correction Of Entry No.';
            Editable = false;
            TableRelation = "HMX Cycle Count Log"."Entry No.";
        }

        field(15; "Correction Reason"; Text[250])
        {
            Caption = 'Correction Reason';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

        key(SessionKey; "Count Session ID", "Entry No.")
        {
        }

        key(ItemHistory; "Item No.", "Location Code", "Count Date")
        {
        }

        key(CorrectionKey; "Correction Of Entry No.")
        {
        }
    }

    trigger OnModify()
    begin
        if xRec.Status = xRec.Status::Completed then
            Error(
                'Logged cycle-count records cannot be changed. Use Reopen Selected Count first.');
    end;

    procedure UpdateBCQuantity()
    var
        ItemRecord: Record Item;
    begin
        "BC Qty" := 0;

        if ("Item No." = '') or ("Location Code" = '') then begin
            UpdateAccuracy();
            exit;
        end;

        if not ItemRecord.Get("Item No.") then begin
            UpdateAccuracy();
            exit;
        end;

        ItemRecord.SetRange("Location Filter", "Location Code");
        ItemRecord.CalcFields(Inventory);

        "BC Qty" := ItemRecord.Inventory;

        UpdateAccuracy();
    end;

    procedure UpdateAccuracy()
    var
        DifferenceQty: Decimal;
        ComparisonQty: Decimal;
    begin
        if not "Count Entered" then begin
            "Variance" := 0;
            exit;
        end;

        if ("BC Qty" = 0) and ("Count Qty" = 0) then begin
            "Variance" := 100;
            exit;
        end;

        if ("BC Qty" = 0) or ("Count Qty" = 0) then begin
            "Variance" := 0;
            exit;
        end;

        DifferenceQty := Abs("Count Qty" - "BC Qty");

        if Abs("BC Qty") > Abs("Count Qty") then
            ComparisonQty := Abs("BC Qty")
        else
            ComparisonQty := Abs("Count Qty");

        if ComparisonQty = 0 then
            "Variance" := 100
        else
            "Variance" :=
                100 * (1 - (DifferenceQty / ComparisonQty));

        if "Variance" < 0 then
            "Variance" := 0;

        if "Variance" > 100 then
            "Variance" := 100;
    end;

    local procedure UpdateSessionID()
    var
        DateText: Text;
    begin
        if ("Count Date" = 0D) or ("Location Code" = '') then begin
            "Count Session ID" := '';
            exit;
        end;

        DateText :=
            Format("Count Date", 0, '<Year4><Month,2><Day,2>');

        "Count Session ID" :=
            CopyStr(StrSubstNo('%1-%2', "Location Code", DateText), 1, MaxStrLen("Count Session ID"));
    end;
}
