pageextension 52613 "HMX DSHIP Package Worksheet" extends "DSHIP Package Worksheet"
{
    ModifyAllowed = true;
    actions
    {
        addlast("&Print")
        {
            action("HMX Test")
            {
                trigger OnAction()
                begin
                    // Message('Test');
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        //Message('Tes 2');
    end;
}
