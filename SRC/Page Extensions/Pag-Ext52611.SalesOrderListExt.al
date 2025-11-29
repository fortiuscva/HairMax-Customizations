pageextension 52611 "HMX SalesOrderListExt" extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(processing)
        {
            action("HMX RemoveTaxDetails")
            {
                Caption = 'Remove Tax Area code & Tax liability';
                ToolTip = 'To remove the Tax Area Code & Tax Liability for the shopify orders';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    Salesheaderrec: Record "Sales Header";
                begin
                    Salesheaderrec.Reset();
                    Salesheaderrec.SetFilter("Shpfy Order No.", '<>%1', '');
                    CurrPage.SetSelectionFilter(Salesheaderrec);
                    if Salesheaderrec.FindSet() then begin
                        Salesheaderrec.ModifyAll("Tax Liable", false);
                        Salesheaderrec.ModifyAll("Tax Area Code", '');
                        Message('Selceted records have been modifies!');
                    end;
                end;

            }

        }

    }


}