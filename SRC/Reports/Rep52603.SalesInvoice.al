report 52603 "HMX Sales Invoice"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Hairmax Sales Invoice Report';
    RDLCLayout = './SRC/RDL/HairmaxSalesInvoice.rdl';

    dataset
    {
        dataitem("Sales_Header"; "Sales Invoice Header")
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
            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(Ship_to_Address; "Ship-to Address")
            {

            }
            column(Ship_to_Address_2; "Ship-to Address 2")
            {

            }
            column(Ship_to_City; "Ship-to City")
            {

            }
            column(Ship_to_County; "Ship-to County")
            {

            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {

            }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code")
            {

            }


            column(EncodeTextCode39; this.EncodeTextCode39)
            {

            }
            column(ShippingMthDesc; ShippingMthDesc)
            {

            }
            column(Due_Date; "Due Date")
            {

            }
            column(Shipment_Date; "Shipment Date")
            {

            }
            column(Package_Tracking_No_; "Package Tracking No.")
            {

            }
            column(WorkDescriptionLine_Grec; this.WorkDescriptionLine_Grec)
            {

            }
            column(commentarray_Grec; commentarray_Grec)
            {

            }

            column(paymentTermsDesc; PaymentTermsDesc)
            {

            }
            column(SalesPurchaseDesc; SalesPurchaseDesc)
            {

            }

            dataitem("Sales Line"; "Sales Invoice Line")
            {
                DataItemLinkReference = "Sales_Header";
                DataItemLink = "Document No." = field("No.");


                column(Quantity; Quantity)
                {

                }
                column(ItemNo; "No.")
                {

                }
                column(PrintLine; this.PrintLine)
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
                column(ShippingAmount_GRec; this.ShippingAmount_GRec)
                {

                }

                trigger OnPreDataItem()

                begin

                    Clear(this.TotalAmount_Grec);
                    Clear(this.SubTotalAmount_GRec);
                    Clear(ShippingAmount_GRec);
                end;

                trigger OnAfterGetRecord()

                begin
                    Clear(this.Rate_GRec);
                    Clear(this.Amount_GRec);
                    Clear(this.Serial_LotNo_GRec);

                    Clear(this.PrintLine);
                    // if "Sales Line".Type = "Sales Line".Type::Item then begin
                    this.Rate_GRec := ("Sales Line"."Unit Price" - ("Sales Line"."Unit Price" * "Sales Line"."Line Discount %") / 100);
                    this.Amount_GRec := this.Rate_GRec * "Sales Line".Quantity;
                    if not (("Sales Line".Type = "Sales Line".Type::"G/L Account") and ("Sales Line"."No." = '40391')) then
                        this.SubTotalAmount_GRec += this.Amount_GRec;
                    this.PrintLine := true;
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

                    // end;

                    if ("Sales Line".Type = "Sales Line".Type::"G/L Account") and ("Sales Line"."No." = '40391') then
                        this.ShippingAmount_GRec += "Sales Line".Amount;
                    this.TotalAmount_Grec := this.SubTotalAmount_GRec + this.ShippingAmount_GRec;
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
                Clear(PaymentTermsDesc);
                Clear(SalesPurchaseDesc);
                Clear(this.WorkDescriptionInstream_GRec);
                Clear(this.WorkDescriptionLine_Grec);
                Clear(commentarray_Grec);
                Sales_Header.CalcFields("Work Description");
                Sales_Header."Work Description".CreateInStream(this.WorkDescriptionInstream_GRec, TextEncoding::UTF8);
                this.WorkDescriptionInstream_GRec.ReadText(this.WorkDescriptionLine_Grec);

                if this.SalesPurchaseCode_Grec.Get(Sales_Header."Salesperson Code") then
                    SalesPurchaseDesc := this.SalesPurchaseCode_Grec.Name;
                if this.PaymentTerms_GRec.Get(Sales_Header."Payment Terms Code") then
                    PaymentTermsDesc := this.PaymentTerms_GRec.Description;
                if this.ShippingMethod_GRec.Get(Sales_Header."Shipment Method Code") then
                    ShippingMthDesc := this.ShippingMethod_GRec.Description;

                //Comments
                SalesOrderComments_GRec.Reset();
                SalesOrderComments_GRec.SetRange("No.", Sales_Header."No.");
                SalesOrderComments_GRec.SetRange("Document Type", SalesOrderComments_GRec."Document Type"::"Posted Invoice");
                if SalesOrderComments_GRec.FindSet() then
                    repeat
                        if commentarray_Grec = '' then
                            commentarray_Grec := SalesOrderComments_GRec.Comment
                        else
                            commentarray_Grec += ' ,' + SalesOrderComments_GRec.Comment;
                    until SalesOrderComments_GRec.Next() = 0;

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
        InvoiceLabel = 'Invoice';
        DateLabel = 'Date';
        InvoiceNoLabel = 'Invoice #';
        TermsLabel = 'Terms';
        dueDateLabel = 'Due Date';
        SalesRepLabel = 'Sales Rep';

        POLabel = 'PO #';
        ProjectLblel = 'Project';
        ShippingMethodLabel = 'Shipping Method';
        ShippingTaxCodeLabel = 'Shipping Tax Code';
        ShippingTaxRateLabel = 'Shipping Tax Rate';
        BillToLbl = 'Bill To';
        ShipToLbl = 'Ship To';
        PartnerLbl = 'Partner';
        ShipViaLbl = 'Ship Via';
        ShipdateLbl = 'Ship Date';
        TrackingNoLbl = 'Tracking #';
        FOBLbl = 'FOB';
        ShippingNotesLbl = 'Shipping Notes';
        CustomerShippingLbl = 'Customer Shipping';

        Itemlabel = 'Item';
        descriptionLabel = 'Description';
        QuantityLabel = 'Quantity';
        UnitsLabel = 'Units';
        OptionsLabel = 'Options';
        SerialLotNoLabel = 'Serial/ Lot Numbers';
        UnitPriceLabel = 'Unit Price';
        RateLabel = 'Rate';
        AmountLabel = 'Amount';
        TaxRateLabel = 'Tax Rate';
        TaxLabel = 'Tax';

        SubtotalLbl = 'Subtotal';
        ShippingCostLbl = 'Shipping Cost(Other)';
        TotalLbl = 'Total';

        InvoicereportLbl = 'At HairMax, we truly care. We hope your experience was satisfactory and we thank you for being a valued HairMax partner.';


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
        SalesOrderComments_GRec: Record "Sales Comment Line";
        SalesPurchaseCode_Grec: Record "Salesperson/Purchaser";
        SalesPurchaseDesc: Text;
        WorkDescriptionLine_Grec: Text;
        WorkDescriptionInstream_GRec: InStream;
        ShippingMthDesc: Text;
        PrintLine: Boolean;
        PaymentTermsDesc: Text;
        ShippingAmount_GRec: Decimal;
        PaymentTerms_GRec: Record "Payment Terms";
        ItemLedEntry_GRec: Record "Item Ledger Entry";
        GenLedSetup_GRec: Record "General Ledger Setup";
        Serial_LotNo_GRec: Text;
        EncodeTextCode39: Text;
        commentarray_Grec: Text;

        Rate_GRec: Decimal;
        Amount_GRec: Decimal;

        TotalAmount_Grec: Decimal;
        SubTotalAmount_GRec: Decimal;

        BarcodeSymbology: Enum "Barcode Symbology";
        ItemVariant: Record "Item Variant";



}