codeunit 52603 "HMX Hairmax Functions"
{
    Permissions = tabledata Contact = rmid;
    procedure UpdateSelltoPhoneNo(SelltoContactNo: Code[20])
    var
        myInt: Integer;
    begin
        SelltoContact.Get(SelltoContactNo);
        if SelltoContact."Phone No." = '' then begin
            SelltoContact.Validate("Phone No.", '561-314-2430');
            SelltoContact.Modify(true);
        end;
    end;

    procedure UpdatePackingGroupComments(var SalesHeader: Record "Sales Header")
    var
        Customer: Record Customer;
        CustomerPackingGroup: Record "HMX Customer Packing Group";
        SalesCommentLine: Record "Sales Comment Line";
        Comments: array[3] of Text;
        CommentText: Text;
        RemainingText: Text;
        LineNo: Integer;
        i: Integer;
        PackingGroupLength: Integer;
    begin
        if SalesHeader."No." = '' then
            exit;

        if not Customer.Get(SalesHeader."Sell-to Customer No.") then
            exit;

        if Customer."HMX Cust. Packing Group Code" = '' then
            exit;

        if not CustomerPackingGroup.Get(Customer."HMX Cust. Packing Group Code") then
            exit;

        Comments[1] := CustomerPackingGroup."Packing Comments";
        Comments[2] := CustomerPackingGroup."Labeling Comments";
        Comments[3] := CustomerPackingGroup."Fulfillment Comments";

        SalesCommentLine.Reset();
        SalesCommentLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesCommentLine.SetRange("No.", SalesHeader."No.");
        SalesCommentLine.SetRange("Document Line No.", 0);
        SalesCommentLine.SetRange(Code, CustomerPackingGroup.Code);

        if not SalesCommentLine.IsEmpty() then
            exit;
        SalesCommentLine.Reset();
        SalesCommentLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesCommentLine.SetRange("No.", SalesHeader."No.");

        if SalesCommentLine.FindLast() then
            LineNo := SalesCommentLine."Line No." + 10000
        else
            LineNo := 10000;

        PackingGroupLength := MaxStrLen(SalesCommentLine.Comment);

        for i := 1 to ArrayLen(Comments) do begin
            CommentText := DelChr(Comments[i], '<>', ' ');

            if CommentText <> '' then begin
                RemainingText := CommentText;

                while RemainingText <> '' do begin
                    SalesCommentLine.Init();

                    SalesCommentLine."Document Type" := SalesHeader."Document Type";
                    SalesCommentLine."No." := SalesHeader."No.";
                    SalesCommentLine."Line No." := LineNo;
                    SalesCommentLine."Document Line No." := 0;
                    SalesCommentLine.Date := WorkDate();
                    SalesCommentLine.Code := CopyStr(CustomerPackingGroup.Code, 1, MaxStrLen(SalesCommentLine.Code));
                    SalesCommentLine.Comment := CopyStr(RemainingText, 1, PackingGroupLength);
                    SalesCommentLine.Insert(true);

                    RemainingText := CopyStr(RemainingText, StrLen(SalesCommentLine.Comment) + 1);

                    LineNo += 10000;
                end;
            end;
        end;
    end;

    var
        SelltoContact: Record Contact;
}
