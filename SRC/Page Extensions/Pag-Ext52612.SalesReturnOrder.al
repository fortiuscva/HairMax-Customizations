namespace HairMaxCustomizations.HairMaxCustomizations;

using Microsoft.Sales.Document;
using System.Security.AccessControl;
using System.Security.User;

pageextension 52612 "HMX Sales Return Order" extends "Sales Return Order"
{
    layout
    {
        modify("Customer Posting Group")
        {
            Editable = true;
            trigger OnBeforeValidate()
            var
                UserSetupRecLcl: Record "User Setup";
                EditNotAllowedLbl: Label 'User %1 is not allowed to edit this field';
            begin
                if UserSetupRecLcl.Get(UserId) then begin
                    if not UserSetupRecLcl."HMX Edit Cust. Post. Group" then
                        Error(StrSubstNo(EditNotAllowedLbl, UserId));
                end;
            end;
        }
    }
}
