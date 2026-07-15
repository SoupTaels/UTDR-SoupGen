// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum WebViewJavaScriptEvent
{
    OnUrlChange((int)0),
    OnBodyChange((int)1),
    OnTitleChange((int)2),
    OnButtonPress((int)3),
    OnPageLoadStart((int)4),
    OnPageLoadEnd((int)5),
    OnCustomPost((int)6);

    private final int value;
    private WebViewJavaScriptEvent(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static WebViewJavaScriptEvent from(int v)
    {
        switch (v)
        {
            case 0:
                return WebViewJavaScriptEvent.OnUrlChange;
            case 1:
                return WebViewJavaScriptEvent.OnBodyChange;
            case 2:
                return WebViewJavaScriptEvent.OnTitleChange;
            case 3:
                return WebViewJavaScriptEvent.OnButtonPress;
            case 4:
                return WebViewJavaScriptEvent.OnPageLoadStart;
            case 5:
                return WebViewJavaScriptEvent.OnPageLoadEnd;
            case 6:
                return WebViewJavaScriptEvent.OnCustomPost;
            default:
                throw new IllegalArgumentException("Unknown WebViewJavaScriptEvent value: " + v);
        }
    }
}