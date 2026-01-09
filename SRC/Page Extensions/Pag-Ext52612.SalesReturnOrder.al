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
            Editable = IsCustomerPostingGroupEditable;
        }
    }
    trigger OnOpenPage()
    var
        UserSetupRec: Record "User Setup";
    begin
        IsCustomerPostingGroupEditable := false;
        if UserSetupRec.Get(UserId) then begin
            if UserSetupRec."HMX Edit Cust. Post. Group" then
                IsCustomerPostingGroupEditable := true;
        end;
    end;

    var
        IsCustomerPostingGroupEditable: Boolean;
}
