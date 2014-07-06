//-----------------------------------------------------------
//
//-----------------------------------------------------------
class gTabHelp extends GUITabPanel;


var() localized string Text;

var automated GUIScrollTextBox lb_Desc;


function InitComponent(GUIController MyController, GUIComponent MyComponent)
{
    Super.InitComponent(MyController, MyComponent);

    // make scrollbar fixed size
    lb_Desc.MyScrollBar.WinWidth = 16;

    // load text
    lb_Desc.SetContent(Text);
}

DefaultProperties
{
    Begin Object Class=GUIScrollTextBox Name=ODescription
        WinWidth=1.0
        WinHeight=0.8
        WinLeft=0.0
        WinTop=0.050000
        bNoTeletype=True
        CharDelay=0.0015
        EOLDelay=0.25
        bNeverFocus=True
        bAcceptsInput=False
        bVisibleWhenEmpty=True
        StyleName="gNoBackgroundFixed"
        bScaleToParent=True
        bBoundToParent=True
    End Object
    lb_Desc=ODescription
}
