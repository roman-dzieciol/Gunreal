// ============================================================================
//  g2K4Tab_MainSP.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class g2K4Tab_MainSP extends UT2K4Tab_MainSP;


var gMapFilter MapFilter;




// Query the CacheManager for the maps that correspond to this gametype, then fill the main list
function InitMaps( optional string MapPrefix )
{
    local int i, j, k, BV;
    local bool bTemp;
    local string Package, Item, CurrentItem, Desc;
    local GUITreeNode StoredItem;
    local DecoText DT;
    local array<string> CustomLinkSetups;

    // Make sure we have a map prefix
    if ( MapPrefix == "" )
        MapPrefix = GetMapPrefix();

    // Temporarily disable notification in all components
    bTemp = Controller.bCurMenuInitialized;
    Controller.bCurMenuInitialized = False;

    if ( li_Maps.IsValid() )
        li_Maps.GetElementAtIndex(li_Maps.Index, StoredItem);

    // Get the list of maps for the current gametype
    class'CacheManager'.static.GetMapList( CacheMaps, MapPrefix );
    if ( MapHandler.GetAvailableMaps(MapHandler.GetGameIndex(CurrentGameType.ClassName), Maps) )
    {
        li_Maps.bNotify = False;
        li_Maps.Clear();

        for ( i = 0; i < Maps.Length; i++ )
        {
            // Gunreal: filter out maps
            if( MapFilter.GetFilter(Maps[i].MapName) > F_Maybe )
                continue;

            DT = None;
            if ( class'CacheManager'.static.IsDefaultContent(Maps[i].MapName) )
            {
                if ( bOnlyShowCustom )
                    continue;
            }
            else if ( bOnlyShowOfficial )
                continue;

            j = FindCacheRecordIndex(Maps[i].MapName);
            if ( class'CacheManager'.static.Is2003Content(Maps[i].MapName) )
            {
                if ( CacheMaps[j].TextName != "" )
                {
                    if ( !Divide(CacheMaps[j].TextName, ".", Package, Item) )
                {
                        Package = "XMaps";
                        Item = CacheMaps[j].TextName;
                    }
                }

                DT = class'xUtil'.static.LoadDecoText(Package, Item);
            }

            if ( DT != None )
                Desc = JoinArray(DT.Rows, "|");
            else
                Desc =CacheMaps[j].Description;

            li_Maps.AddItem( Maps[i].MapName, Maps[i].MapName, ,,Desc);

            // for now, limit this to power link setups only
            if ( CurrentGameType.MapPrefix ~= "ONS" )
            {

                // Big Hack Time for the bonus pack

                CurrentItem = Maps[i].MapName;
                for (BV=0;BV<2;BV++)
                {
                    if ( Maps[i].Options.Length > 0 )
                    {
                        Package = CacheMaps[j].Description;

                        // Add the "auto link setup" item
                        li_Maps.AddItem( AutoSelectText @ LinkText, Maps[i].MapName $ "?LinkSetup=Random", CurrentItem,,Package );

                        // Now add all official link setups
                        for ( k = 0; k < Maps[i].Options.Length; k++ )
                        {
                            li_Maps.AddItem(Maps[i].Options[k].Value @ LinkText, Maps[i].MapName $ "?LinkSetup=" $ Maps[i].Options[k].Value, CurrentItem,,Package );
                        }
                    }

                    // Now to add the custom setups
                    CustomLinkSetups = GetPerObjectNames(Maps[i].MapName, "ONSPowerLinkCustomSetup");
                    for ( k = 0; k < CustomLinkSetups.Length; k++ )
                    {
                        li_Maps.AddItem(CustomLinkSetups[k] @ LinkText, Maps[i].MapName $ "?" $ "LinkSetup=" $ CustomLinkSetups[k], CurrentItem,,Package);
                    }

                    if ( !OrigONSMap(Maps[i].MapName) )
                        break;

                    else if (BV<1 && Controller.bECEEdition)
                    {
                        li_Maps.AddItem( Maps[i].MapName$BonusVehicles, Maps[i].MapName, ,,BonusVehiclesMsg$Package);
                        CurrentItem=CurrentItem$BonusVehicles;
                    }

                    if ( !Controller.bECEEdition )  // Don't do the second loop if not the ECE
                        break;

                }

            }
        }
    }

    if ( li_Maps.bSorted )
        li_Maps.SortList();

    if ( StoredItem.Caption != "" )
    {
        i = li_Maps.FindFullIndex(StoredItem.Caption, StoredItem.Value, StoredItem.ParentCaption);
        if ( i != -1 )
            li_Maps.SilentSetIndex(i);
    }

    li_Maps.bNotify = True;

    Controller.bCurMenuInitialized = bTemp;
}

DefaultProperties
{


    Begin Object Class=gMapFilter Name=OMapFilter
    End Object
    MapFilter=OMapFilter
}