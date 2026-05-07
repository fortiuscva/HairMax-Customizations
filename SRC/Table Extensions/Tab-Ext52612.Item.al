namespace HairMaxCustomizations.HairMaxCustomizations;
using Microsoft.Inventory.Item;


tableextension 52612 Item extends Item
{
    fields
    {
        field(52600; "HMX Signature"; Boolean)
        {
            Caption = 'Signature';
            DataClassification = CustomerContent;
        }
    }
}
