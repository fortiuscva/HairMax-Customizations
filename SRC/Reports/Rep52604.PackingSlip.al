report 52604 "HMX Packing Slip"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Hairmax Packing Slip Report';
    RDLCLayout = './SRC/RDL/HairmaxPackingSlip.rdl';

    dataset
    {
        dataitem("Sales_Header"; "Sales Shipment Header")
        {

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
            column(ShippingMthDesc; this.ShippingMthDesc)
            {

            }


            column(EncodeTextCode39; this.EncodeTextCode39)
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
            column(Order_No_; "Order No.")
            {

            }



            dataitem("Sales Line"; "Sales Shipment Line")
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
                column(ItemNoBarcode; this.ItemNoBarCode39)
                { }


                column(Serial_LotNo_GRec; this.Serial_LotNo_GRec)
                {

                }
                column(OrderQty; this.OrderQty)
                {

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

                    Clear(this.Serial_LotNo_GRec);
                    Clear(OrderQty);
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

                    SalesLine_GRec.Reset();
                    SalesLine_GRec.SetRange("Document No.", "Sales Line"."Document No.");
                    SalesLine_GRec.SetRange("Type", SalesLine_GRec.Type::Item);
                    SalesLine_GRec.SetRange("No.", "Sales Line"."No.");
                    if SalesLine_GRec.FindFirst() then
                        OrderQty := SalesLine_GRec.Quantity
                    else
                        OrderQty := "Sales Line".Quantity;
                    BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                    BarcodeSymbology := Enum::"Barcode Symbology"::"Code39";
                    BarcodeString := UpperCase(ConvertStr("Sales Line"."No.", '_', ' '));
                    BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                    this.ItemNoBarCode39 := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
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
                if Shippingmethod_GRec.Get("Sales_Header"."Shipment Method Code") then
                    ShippingMthDesc := Shippingmethod_GRec.Description;
                //Print barcode
                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbology := Enum::"Barcode Symbology"::"Code39";
                BarcodeString := "Order No.";
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
        PackingSlipLable = 'Packing Slip';
        OrderdateLbl = 'Order Date';
        OrderNoLabel = 'Order #';


        ShipToLbl = 'Ship To';
        MemoLbl = 'Memo';
        ShipViaLbl = 'Ship Via';
        ShipdateLbl = 'Ship Date';
        TrackingNoLbl = 'Tracking #';
        Itemlabel = 'Item';
        OrderedLbl = 'Ordered';
        ShippedLbl = 'Shipped';
        descriptionLabel = 'Description';
        QuantityLabel = 'Quantity';
        UnitsLabel = 'Units';
        OptionsLabel = 'Options';
        BackOrderedLabel = 'Back Ordered';
        SerialLotNoLabel = 'Serial/ Lot Numbers';
        ItemBarcodeLbl = 'Item Barcode';

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

        Shippingmethod_GRec: Record "Shipment Method";

        ShippingMthDesc: Text;
        PrintLine: Boolean;
        OrderQty: Decimal;
        SalesLine_GRec: Record "Sales Line";


        ItemLedEntry_GRec: Record "Item Ledger Entry";
        GenLedSetup_GRec: Record "General Ledger Setup";
        Serial_LotNo_GRec: Text;
        EncodeTextCode39: Text;
        ItemNoBarCode39: Text;
        BarcodeSymbology: Enum "Barcode Symbology";
}