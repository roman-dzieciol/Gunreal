// ============================================================================
//  gStateTestSub.uc ::
// ============================================================================
class gStateTestSub extends gStateTest;


state BaseState
{
    function FA()
    {
        Log("gStateTestSub.BaseState.A");
        Super.FA();
    }

    function FB()
    {
        Log("gStateTestSub.BaseState.B");
        Super.FB();
    }
}


state ExtendedState
{
    function FA()
    {
        Log("gStateTestSub.ExtendedState.A");
        Super.FA();
    }
}

DefaultProperties
{

}