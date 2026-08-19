namespace HairMaxCustomizations.HairMaxCustomizations;

page 52605 "HMX Cycle Count Log"
{
    ApplicationArea = All;
    Caption = 'Cycle Count Log';
    PageType = Worksheet;
    SourceTable = "HMX Cycle Count Log";
    UsageCategory = Lists;

    DelayedInsert = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Count Date"; Rec."Count Date")
                {
                    ApplicationArea = All;
                    Editable = Rec.Status = Rec.Status::Open;
                }

                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = Rec.Status = Rec.Status::Open;

                    ToolTip =
                        'Specifies the location where the item was counted.';
                }

                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = Rec.Status = Rec.Status::Open;

                    ToolTip =
                        'Specifies the item that was counted.';
                }

                field("On Hand Qty"; Rec."BC Qty")
                {
                    ApplicationArea = All;
                    Caption = 'On Hand Qty';
                    Editable = false;

                    ToolTip =
                        'Shows the Business Central quantity on hand for the selected item and location.';
                }

                field("Count Qty"; Rec."Count Qty")
                {
                    ApplicationArea = All;
                    Editable = Rec.Status = Rec.Status::Open;

                    ToolTip =
                        'Specifies the physical quantity counted.';
                }

                field("Accuracy Percent"; Rec."Variance")
                {
                    ApplicationArea = All;
                    Caption = 'Accuracy %';
                    Editable = false;

                    ToolTip =
                        'Shows the calculated inventory accuracy percentage.';
                }

                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    Editable = Rec.Status = Rec.Status::Open;

                    ToolTip =
                        'Specifies optional notes about the count.';
                }

                field("Count Session ID"; Rec."Count Session ID")
                {
                    ApplicationArea = All;
                    Editable = false;

                    ToolTip =
                        'Groups count lines by count date and location.';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Logged By"; Rec."Counted By")
                {
                    ApplicationArea = All;
                    Caption = 'Logged By';
                    Editable = false;
                }

                field("Logged Date Time"; Rec."Completed Date Time")
                {
                    ApplicationArea = All;
                    Caption = 'Logged Date/Time';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(LogSelectedCount)
            {
                Caption = 'Log Selected Count';
                ApplicationArea = All;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CycleCountLine: Record "HMX Cycle Count Log";
                    LoggedAt: DateTime;
                    LoggedBy: Text;
                    LoggedLines: Integer;
                begin
                    CurrPage.SetSelectionFilter(CycleCountLine);

                    if CycleCountLine.IsEmpty() then
                        Error(
                            'Select at least one cycle-count line.');

                    LoggedAt := CurrentDateTime();
                    LoggedBy := UserId();

                    if CycleCountLine.FindSet(true) then
                        repeat
                            if CycleCountLine.Status =
                               CycleCountLine.Status::Open
                            then begin
                                CycleCountLine.TestField("Count Date");

                                CycleCountLine.TestField("Location Code");

                                CycleCountLine.TestField("Item No.");

                                if not CycleCountLine."Count Entered" then
                                    Error(
                                        'Enter the Count Qty for item %1 before logging the count. A quantity of zero is allowed, but the field must be entered.',
                                        CycleCountLine."Item No.");

                                CycleCountLine.UpdateBCQuantity();
                                CycleCountLine.UpdateAccuracy();

                                CycleCountLine."Counted By" :=
                                    CopyStr(LoggedBy, 1, MaxStrLen(CycleCountLine."Counted By"));

                                CycleCountLine."Completed Date Time" :=
                                    LoggedAt;

                                CycleCountLine.Status :=
                                    CycleCountLine.Status::Completed;

                                // Controlled update allows the line
                                // to move from Open to Logged.
                                CycleCountLine.Modify(false);

                                LoggedLines += 1;
                            end;
                        until CycleCountLine.Next() = 0;

                    if LoggedLines = 0 then
                        Message(
                            'The selected cycle-count lines were already logged.')
                    else
                        Message(
                            '%1 cycle-count line(s) logged successfully.',
                            LoggedLines);

                    CurrPage.Update(false);
                end;
            }

            action(ReopenSelectedCount)
            {
                Caption = 'Reopen Selected Count';
                ApplicationArea = All;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CycleCountLine: Record "HMX Cycle Count Log";
                    ReopenedLines: Integer;
                begin
                    CurrPage.SetSelectionFilter(CycleCountLine);

                    if CycleCountLine.IsEmpty() then
                        Error('Select at least one logged cycle-count line.');

                    if not Confirm('Reopen the selected cycle-count line(s) for editing?', false)
                    then
                        exit;

                    if CycleCountLine.FindSet(true) then
                        repeat
                            if CycleCountLine.Status =
                               CycleCountLine.Status::Completed
                            then begin
                                CycleCountLine.Status :=
                                    CycleCountLine.Status::Open;

                                CycleCountLine."Counted By" := '';

                                Clear(
                                    CycleCountLine.
                                        "Completed Date Time");

                                // Controlled update bypasses the
                                // Logged-record modification protection.
                                CycleCountLine.Modify(false);

                                ReopenedLines += 1;
                            end;
                        until CycleCountLine.Next() = 0;

                    if ReopenedLines = 0 then
                        Message('The selected cycle-count lines were already open.')
                    else
                        Message('%1 cycle-count line(s) reopened for editing.', ReopenedLines);

                    CurrPage.Update(false);
                end;
            }
        }
    }
}
