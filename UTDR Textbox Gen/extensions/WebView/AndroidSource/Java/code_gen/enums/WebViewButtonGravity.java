// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum WebViewButtonGravity
{
    Left((int)3),
    Right((int)5),
    Top((int)48),
    Bottom((int)80),
    Start((int)8388611),
    End((int)8388613),
    CenterHorizontal((int)1),
    CenterVertical((int)16),
    Center((int)17);

    private final int value;
    private WebViewButtonGravity(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static WebViewButtonGravity from(int v)
    {
        switch (v)
        {
            case 3:
                return WebViewButtonGravity.Left;
            case 5:
                return WebViewButtonGravity.Right;
            case 48:
                return WebViewButtonGravity.Top;
            case 80:
                return WebViewButtonGravity.Bottom;
            case 8388611:
                return WebViewButtonGravity.Start;
            case 8388613:
                return WebViewButtonGravity.End;
            case 1:
                return WebViewButtonGravity.CenterHorizontal;
            case 16:
                return WebViewButtonGravity.CenterVertical;
            case 17:
                return WebViewButtonGravity.Center;
            default:
                throw new IllegalArgumentException("Unknown WebViewButtonGravity value: " + v);
        }
    }
}