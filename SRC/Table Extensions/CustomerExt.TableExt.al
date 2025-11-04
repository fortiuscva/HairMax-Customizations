tableextension 52603 CustomerExt extends Customer
{
    fields
    {
        field(50000; "Interaction Template Code"; Code[10])
        {
            Caption = 'Interaction Template Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the interaction template code';
            TableRelation = "Interaction Template";
            trigger OnValidate()
            begin

                SegmentLine.Validate("Interaction Template Code", Rec."Interaction Template Code");
            end;
        }
        field(50001; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the description for the interaction';

            trigger OnValidate()
            begin
                SegmentLine.Validate(Description, Rec.Description);
            end;
        }
        field(50002; Salesperson; Code[20])
        {
            Caption = 'Sales Person';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Sales person assigned for the inetraction';
            TableRelation = "Salesperson/Purchaser" where(Blocked = const(false));

            trigger OnValidate()
            begin
                SegmentLine.Validate("Salesperson Code", Rec."Salesperson Code");
            end;
        }
        field(50003; "Interaction Language Code"; Code[10])
        {
            Caption = 'Language Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Intercation Language Code';
            TableRelation = Language;

            trigger OnValidate()
            begin
                SegmentLine.Validate("Language Code", Rec."Interaction Language Code");
            end;
        }
        field(50004; "Date of Interaction"; Date)
        {
            Caption = 'Date of Interaction';
            DataClassification = CustomerContent;
            ToolTip = 'Sepcifies the date of intercation';
            trigger OnValidate()
            begin
                SegmentLine.Validate(Date, Rec."Date of Interaction");
            end;
        }
        field(50005; "Time of Interaction"; Time)
        {
            Caption = 'Time of Interaction';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the time of intercation';
            trigger OnValidate()
            begin
                SegmentLine.Validate("Time of Interaction", Rec."Time of Interaction");
            end;
        }
        field(50006; "Correspondence Type"; Enum "Correspondence Type")
        {
            Caption = 'Correspondence Type';
            DataClassification = CustomerContent;
            ToolTip = 'Sepcifies the correspondence type for the interaction';
            trigger OnValidate()
            begin
                SegmentLine.Validate("Correspondence Type", Rec."Correspondence Type");
            end;
        }
        field(50007; "Information Flow"; Option)
        {
            BlankZero = true;
            Caption = 'Information Flow';
            OptionCaption = ' ,Outbound,Inbound';
            OptionMembers = " ",Outbound,Inbound;
            ToolTip = 'Sepcifies the information flow for the intercation';
            trigger OnValidate()
            begin
                SegmentLine.Validate("Information Flow", Rec."Information Flow");
            end;
        }
        field(50008; "Initiated By"; Option)
        {
            BlankZero = true;
            Caption = 'Initiated By';
            OptionCaption = ' ,Us,Them';
            OptionMembers = " ",Us,Them;
            ToolTip = 'Specifies who initiated the interaction';
            trigger OnValidate()
            begin
                SegmentLine.Validate("Initiated By", Rec."Initiated By");
            end;
        }
        field(50009; Comments; Text[80])
        {
            Caption = 'Comments';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the comments for the interaction';

        }

        field(50010; "Evaluation"; Enum "Interaction Evaluation")
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the interaction evaluation';
        }
        field(50011; "Was Successful"; Boolean)
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies is the intercation was successful';
        }
        field(50012; Cost; Decimal)
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the cost of the intercation';
        }
        field(50013; Duration; Decimal)
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the duration of the interaction';
        }

    }
    local procedure InitSegmentLine(CustomerRec: Record Customer)
    var
        SegementHeader: Record "Segment Header";
    begin

    end;

    var
        SegmentLine: Record "Segment Line";
        CreateIntercation: Page "Create Interaction";

}
