// ============================================================================
//  gStateTest.uc ::
// ============================================================================
class gStateTest extends Actor;


function FA()
{
    Log("gStateTest.A");
}

function FB()
{
    Log("gStateTest.B");
}

state BaseState
{
    function FA()
    {
        Log("gStateTest.BaseState.A");
        Global.FA();
    }

    function FB()
    {
        Log("gStateTest.BaseState.B");
        Global.FB();
    }
}


state ExtendedState extends BaseState
{
    function FA()
    {
        Log("gStateTest.ExtendedState.A");
        Super.FA();
    }
}

function TestState()
{
    log( "" );
    log( "STATE NONE" );
    GotoState('');
    FA();
    log( "" );
    FB();

    log( "" );
    log( "STATE BaseState" );
    GotoState('BaseState');
    FA();
    log( "" );
    FB();

    log( "" );
    log( "STATE ExtendedState" );
    GotoState('ExtendedState');
    FA();
    log( "" );
    FB();
}

function PostBeginPlay()
{
}


simulated event SetInitialState()
{
    bScriptInitialized = true;
    TestState();
}


DefaultProperties
{

}