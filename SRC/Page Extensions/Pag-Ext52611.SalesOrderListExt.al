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
                    SalesLineRec: Record "Sales Line";
                begin
                    Salesheaderrec.Reset();
                    Salesheaderrec.SetFilter("Shpfy Order No.", '<>%1', '');
                    CurrPage.SetSelectionFilter(Salesheaderrec);
                    if Salesheaderrec.FindSet() then begin

                        repeat
                            Salesheaderrec.Validate("Tax Liable", false);
                            Salesheaderrec.Validate("Tax Area Code", '');
                            Salesheaderrec.Modify();
                            Commit();
                            SalesLineRec.Reset();
                            SalesLineRec.SetRange("Document No.");
                            if SalesLineRec.FindSet() then begin
                                repeat
                                    SalesLineRec.Validate("Tax Area Code", '');
                                    SalesLineRec.Validate("Tax Group Code", '');
                                    SalesLineRec.Modify();
                                until SalesLineRec.Next() = 0;
                            end;
                        until Salesheaderrec.Next() = 0;
                        Message('Selected records have been modified!');
                    end;
                end;

            }

        }

    }


}