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
    begin
        ControlEditableFields();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        ControlEditableFields();
    end;


    var
        IsCustomerPostingGroupEditable: Boolean;
        UserSetup: Record "User Setup";


    procedure ControlEditableFields()
    begin
        IsCustomerPostingGroupEditable := false;
        if UserSetup.Get(UserId) then begin
            if UserSetup."HMX Edit Cust. Post. Group" then
                IsCustomerPostingGroupEditable := true;
        end;
    end;

}
