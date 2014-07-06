// ============================================================================
//  gWithinObject.uc ::
// ============================================================================
class gWithinObject extends Object;

simulated function ClearOuter()
{
    // Undefined behaviour, here I come!
    // Don't remove outer while code in within object is executing
    Outer = None;
}


DefaultProperties
{

}
