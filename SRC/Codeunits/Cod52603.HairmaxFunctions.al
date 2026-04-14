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

    var
        SelltoContact: Record Contact;
}
