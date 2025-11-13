tableextension 52603 "HMX CustomerExt" extends Customer
{
    fields
    {
        field(50000; "HMX Interaction Template Code"; Code[10])
        {
            Caption = 'Interaction Template Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the interaction template code';
            TableRelation = "Interaction Template";

        }
        field(50001; "HMX Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the description for the interaction';


        }
        field(50002; "HMX Salesperson"; Code[20])
        {
            Caption = 'Sales Person';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Sales person assigned for the inetraction';
            TableRelation = "Salesperson/Purchaser" where(Blocked = const(false));


        }
        field(50003; "HMX Interaction Language Code"; Code[10])
        {
            Caption = 'Language Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Intercation Language Code';
            TableRelation = Language;


        }
        field(50004; "HMX Date of Interaction"; Date)
        {
            Caption = 'Date of Interaction';
            DataClassification = CustomerContent;
            ToolTip = 'Sepcifies the date of intercation';

        }
        field(50005; "HMX Time of Interaction"; Time)
        {
            Caption = 'Time of Interaction';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the time of intercation';

        }
        field(50006; "HMX Correspondence Type"; Enum "Correspondence Type")
        {
            Caption = 'Correspondence Type';
            DataClassification = CustomerContent;
            ToolTip = 'Sepcifies the correspondence type for the interaction';

        }
        field(50007; "HMX Information Flow"; Option)
        {
            BlankZero = true;
            Caption = 'Information Flow';
            OptionCaption = ' ,Outbound,Inbound';
            OptionMembers = " ",Outbound,Inbound;
            ToolTip = 'Sepcifies the information flow for the intercation';

        }
        field(50008; "HMX Initiated By"; Option)
        {
            BlankZero = true;
            Caption = 'Initiated By';
            OptionCaption = ' ,Us,Them';
            OptionMembers = " ",Us,Them;
            ToolTip = 'Specifies who initiated the interaction';

        }
        field(50009; "HMX Comments"; Text[80])
        {
            Caption = 'Comments';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the comments for the interaction';
            trigger OnLookup()
            var
                TempInterLogEntryCommentLine: Record "Inter. Log Entry Comment Line";
            begin
                PAGE.RunModal(PAGE::"Inter. Log Entry Comment Sheet", TempInterLogEntryCommentLine);
            end;

        }

        field(50010; "HMX Evaluation"; Enum "Interaction Evaluation")
        {
            Caption = 'Evaluation';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the interaction evaluation';
        }
        field(50011; "HMX Was Successful"; Boolean)
        {
            Caption = 'Was Successful';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies is the intercation was successful';
        }
        field(50012; "HMX Cost"; Decimal)
        {
            Caption = 'Cost';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the cost of the intercation';
        }
        field(50013; "HMX Duration"; Decimal)
        {
            Caption = 'Duration';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the duration of the interaction';
        }

    }
    procedure InitSegmentLine()
    var
        SegmentLine_Lrec: Record "Segment Line";
        LastLineNo_Lrec: Integer;
        CreateIntercation: page "Create Interaction";

    begin
        if (Rec."HMX Interaction Template Code" = '') or (Rec."Primary Contact No." = '') then
            exit;
        SegmentLine_Lrec.Reset();
        SegmentLine_Lrec.SetRange("Contact No.", Rec."Primary Contact No.");
        if SegmentLine_Lrec.FindLast() then
            LastLineNo_Lrec := SegmentLine_Lrec."Line No."
        else
            LastLineNo_Lrec := 0;
        SegmentLine_Lrec.Reset();
        SegmentLine_Lrec.Init();
        SegmentLine_Lrec.Validate("Contact No.", Rec."Primary Contact No.");
        SegmentLine_Lrec.Validate("Line No.", LastLineNo_Lrec + 10000);
        SegmentLine_Lrec.Insert();
        Commit();
        Rec."HMX Date of Interaction" := Today();
        Rec."HMX Time of Interaction" := Time();
        SegmentLine_Lrec.Validate("Interaction Template Code", Rec."HMX Interaction Template Code");
        SegmentLine_Lrec.Validate(Description, Rec."HMX Description");
        SegmentLine_Lrec.Validate("Salesperson Code", Rec."HMX Salesperson");
        SegmentLine_Lrec.Validate("Language Code", Rec."HMX Interaction Language Code");
        SegmentLine_Lrec.Validate(Date, Rec."HMX Date of Interaction");
        SegmentLine_Lrec.Validate("Time of Interaction", Rec."HMX Time of Interaction");
        SegmentLine_Lrec.Validate("Correspondence Type", Rec."HMX Correspondence Type");
        SegmentLine_Lrec.Validate("Information Flow", Rec."HMX Information Flow");
        SegmentLine_Lrec.Validate("Initiated By", Rec."HMX Initiated By");
        SegmentLine_Lrec.Validate(Evaluation, Rec."HMX Evaluation");
        SegmentLine_Lrec.Validate("Interaction Successful", Rec."HMX Was Successful");
        SegmentLine_Lrec.Validate("Cost (LCY)", Rec."HMX Cost");
        SegmentLine_Lrec.Validate("Duration (Min.)", Rec."HMX Duration");
        SegmentLine_Lrec.Modify();
        Commit();
        CreateInteractionLogEntry(SegmentLine_Lrec);
    end;

    local procedure CreateInteractionLogEntry(Var SegmentLine_Lrec: Record "Segment Line")
    var
        InteractionLogEntry_Lrec: Record "Interaction Log Entry";
        NextInteractLogEntryNo: Integer;
        SequenceNoMgt: Codeunit "Sequence No. Mgt.";
    begin
        if (Rec."HMX Interaction Template Code" = '') or (Rec."Primary Contact No." = '') then
            exit;
        Clear(NextInteractLogEntryNo);
        NextInteractLogEntryNo := SequenceNoMgt.GetNextSeqNo(Database::"Interaction Log Entry");
        InteractionLogEntry_Lrec.Reset();
        InteractionLogEntry_Lrec.Init();
        InteractionLogEntry_Lrec.Validate("Entry No.", NextInteractLogEntryNo);
        InteractionLogEntry_Lrec.Validate("Contact No.", SegmentLine_Lrec."Contact No.");
        InteractionLogEntry_Lrec.Validate("Contact Company No.", SegmentLine_Lrec."Contact No.");
        InteractionLogEntry_Lrec.Validate("Interaction Template Code", SegmentLine_Lrec."Interaction Template Code");
        InteractionLogEntry_Lrec.Validate(Description, SegmentLine_Lrec.Description);
        InteractionLogEntry_Lrec.Validate("Salesperson Code", SegmentLine_Lrec."Salesperson Code");
        InteractionLogEntry_Lrec.Validate("Interaction Language Code", SegmentLine_Lrec."Language Code");
        InteractionLogEntry_Lrec.Validate(Date, SegmentLine_Lrec.Date);
        InteractionLogEntry_Lrec.Validate("Time of Interaction", SegmentLine_Lrec."Time of Interaction");
        InteractionLogEntry_Lrec.Validate("Correspondence Type", SegmentLine_Lrec."Correspondence Type");
        InteractionLogEntry_Lrec.Validate("Information Flow", SegmentLine_Lrec."Information Flow");
        InteractionLogEntry_Lrec.Validate("Initiated By", SegmentLine_Lrec."Initiated By");
        InteractionLogEntry_Lrec.Validate(Evaluation, SegmentLine_Lrec.Evaluation);
        InteractionLogEntry_Lrec.Validate("Attempt Failed", not SegmentLine_Lrec."Interaction Successful");
        InteractionLogEntry_Lrec.Validate("Cost (LCY)", SegmentLine_Lrec."Cost (LCY)");
        InteractionLogEntry_Lrec.Validate("Duration (Min.)", SegmentLine_Lrec."Duration (Min.)");
        InteractionLogEntry_Lrec.Insert(true);
        Commit();
        SegmentLine_Lrec.Delete(true);
    end;

    procedure ClearIntercationDetails()
    begin
        Rec."HMX Interaction Template Code" := '';
        Rec."HMX Description" := '';
        Rec."HMX Salesperson" := '';
        Rec."HMX Interaction Language Code" := '';
        Rec."HMX Date of Interaction" := 0D;
        Rec."HMX Comments" := '';
        Rec."HMX Time of Interaction" := 0T;
        Rec."HMX Correspondence Type" := Rec."HMX Correspondence Type"::" ";
        Rec."HMX Information Flow" := Rec."HMX Information Flow"::" ";
        Rec."HMX Initiated By" := Rec."HMX Initiated By"::" ";
        Rec."HMX Evaluation" := Rec."HMX Evaluation"::" ";
        Rec."HMX Was Successful" := false;
        Rec."HMX Cost" := 0;
        Rec."HMX Duration" := 0;
        Rec.Modify();
    end;





}
