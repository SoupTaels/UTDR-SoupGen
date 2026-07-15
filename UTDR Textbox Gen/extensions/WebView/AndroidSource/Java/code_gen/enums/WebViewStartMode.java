// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum WebViewStartMode
{
    Hidden((int)0),
    Visible((int)1);

    private final int value;
    private WebViewStartMode(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static WebViewStartMode from(int v)
    {
        switch (v)
        {
            case 0:
                return WebViewStartMode.Hidden;
            case 1:
                return WebViewStartMode.Visible;
            default:
                throw new IllegalArgumentException("Unknown WebViewStartMode value: " + v);
        }
    }
}