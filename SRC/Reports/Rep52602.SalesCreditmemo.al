report 52602 "HMX Sales Credit memo"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Hairmax Sales Credit memo Report';
    RDLCLayout = './SRC/RDL/HairmaxSalesCreditmemo.rdl';

    dataset
    {
        dataitem("Sales_Header"; "Sales Cr.Memo Header")
        {
            CalcFields = "Work Description";
            RequestFilterFields = "No.";


            column(CompanyInfo_Picture; CompanyInfo_Grec.Picture)
            {
            }
            column(CompanyInfo_Name; this.CompanyInfo_Grec.Name)
            {
            }
            column(CompanyInfo_Address; this.CompanyInfo_Grec.Address)
            {
            }
            column(CompanyInfo_Address2; this.CompanyInfo_Grec."Address 2")
            {
            }
            column(CompanyInfo_City; this.CompanyInfo_Grec.City)
            {
            }
            column(CompanyInfo_State; this.CompanyInfo_Grec.County)
            {
            }
            column(CompanyInfo_ZipCode; this.CompanyInfo_Grec."Post Code")
            {
            }
            column(LocalCurrencySymbol; this.GenLedSetup_GRec."Local Currency Symbol")
            {

            }
            column(No_; "No.")
            {
            }
            column(Order_Date; "Posting Date")
            {
            }


            column(External_Document_No_; "External Document No.")
            {
            }
            column(Bill_to_Name; "Bill-to Name")
            {
            }
            column(Bill_to_Address; "Bill-to Address")
            {
            }
            column(Bill_to_Address_2; "Bill-to Address 2")
            {
            }
            column(Bill_to_City; "Bill-to City")
            {
            }
            column(Bill_to_County; "Bill-to County")
            {
            }
            column(Bill_to_Post_Code; "Bill-to Post Code")
            {
            }
            column(Bill_to_Country_Region_Code; "Bill-to Country/Region Code")
            {
            }


            column(EncodeTextCode39; this.EncodeTextCode39)
            {

            }
            column(ShippingMthDesc; ShippingMthDesc)
            {

            }
            dataitem("Sales Line"; "Sales Cr.Memo Line")
            {
                DataItemLinkReference = "Sales_Header";
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where(Type = const(Item));

                column(Quantity; Quantity)
                {

                }
                column(ItemNo; "No.")
                {

                }

                column(Description; Description)
                {

                }
                column(Amount_GRec; this.Amount_GRec)
                {

                }
                column(Rate_GRec; this.Rate_GRec)
                {

                }

                column(SubTotalAmount_GRec; this.SubTotalAmount_GRec)
                {

                }
                column(TotalAmount_Grec; this.TotalAmount_Grec)
                {

                }


                column(Serial_LotNo_GRec; this.Serial_LotNo_GRec)
                {

                }

                trigger OnPreDataItem()

                begin

                    Clear(this.TotalAmount_Grec);
                    Clear(this.SubTotalAmount_GRec);

                end;

                trigger OnAfterGetRecord()

                begin
                    Clear(this.Rate_GRec);
                    Clear(this.Amount_GRec);
                    Clear(this.Serial_LotNo_GRec);


                    this.Rate_GRec := ("Sales Line"."Unit Price" - ("Sales Line"."Unit Price" * "Sales Line"."Line Discount %") / 100);
                    this.Amount_GRec := this.Rate_GRec * "Sales Line".Quantity;
                    this.SubTotalAmount_GRec += this.Amount_GRec;

                    this.ItemLedEntry_GRec.Reset();
                    this.ItemLedEntry_GRec.SetRange("Document No.", "Sales Line"."Document No.");
                    this.ItemLedEntry_GRec.SetRange("Document Line No.", "Sales Line"."Line No.");
                    if this.ItemLedEntry_GRec.FindSet() then
                        repeat
                            if this.ItemLedEntry_GRec."Serial No." <> '' then
                                this.Serial_LotNo_GRec += this.ItemLedEntry_GRec."Serial No."
                            else
                                this.Serial_LotNo_GRec += this.ItemLedEntry_GRec."Lot No.";
                        until ItemLedEntry_GRec.Next() = 0;

                    this.TotalAmount_Grec := this.SubTotalAmount_GRec;



                end;

                trigger OnPostDataItem()

                begin

                end;


            }
            trigger OnPreDataItem()

            begin


            end;

            trigger OnAfterGetRecord()
            var
                BarcodeString: Text;
                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeFontProvider: Interface "Barcode Font Provider";
            begin
                Clear(ShippingMthDesc);

                if this.ShippingMethod_GRec.Get(Sales_Header."Shipment Method Code") then
                    ShippingMthDesc := this.ShippingMethod_GRec.Description;

                //Print barcode
                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbology := Enum::"Barcode Symbology"::"Code39";
                BarcodeString := "No.";
                BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                this.EncodeTextCode39 := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
            end;


        }





    }
    requestpage

    {
        SaveValues = true;
    }

    labels
    {
        SaleCreditMemoLabel = 'Credit Memo';
        DateLabel = 'Date';
        CreditLabel = 'Credit #';
        POLabel = 'PO #';
        ProjectLblel = 'Project';
        ShippingMethodLabel = 'Shipping Method';
        ShippingTaxCodeLabel = 'Shipping Tax Code';
        ShippingTaxRateLabel = 'Shipping Tax Rate';
        BillToLbl = 'Bill To';
        Itemlabel = 'Item';
        descriptionLabel = 'Description';
        QuantityLabel = 'Quantity';
        UnitsLabel = 'Units';
        OptionsLabel = 'Options';
        SerialLotNoLabel = 'Serial/ Lot Numbers';
        RateLabel = 'Rate';
        AmountLabel = 'Amount';
        TaxRateLabel = 'Tax Rate';
        TaxLabel = 'Tax';

        SubtotalLbl = 'Subtotal';
        TotalLbl = 'Total';




    }
    trigger OnPreReport()
    begin
        if this.CompanyInfo_Grec.Get() then
            this.CompanyInfo_Grec.CalcFields(Picture);
        if this.GenLedSetup_GRec.Get() then;
    end;

    trigger OnInitReport()

    begin
        BarcodeSymbology := Enum::"Barcode Symbology"::Code39;
    end;



    var
        CompanyInfo_Grec: Record "Company Information";
        ShippingMethod_GRec: Record "Shipment Method";
        ShippingMthDesc: Text;
        ItemLedEntry_GRec: Record "Item Ledger Entry";
        GenLedSetup_GRec: Record "General Ledger Setup";
        Serial_LotNo_GRec: Text;
        EncodeTextCode39: Text;

        Rate_GRec: Decimal;
        Amount_GRec: Decimal;

        TotalAmount_Grec: Decimal;
        SubTotalAmount_GRec: Decimal;

        BarcodeSymbology: Enum "Barcode Symbology";



}