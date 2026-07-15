// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum WebViewButtonAssetType
{
    DefaultIcon((int)0),
    FilePath((int)1),
    Base64Data((int)2),
    RawData((int)3);

    private final int value;
    private WebViewButtonAssetType(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static WebViewButtonAssetType from(int v)
    {
        switch (v)
        {
            case 0:
                return WebViewButtonAssetType.DefaultIcon;
            case 1:
                return WebViewButtonAssetType.FilePath;
            case 2:
                return WebViewButtonAssetType.Base64Data;
            case 3:
                return WebViewButtonAssetType.RawData;
            default:
                throw new IllegalArgumentException("Unknown WebViewButtonAssetType value: " + v);
        }
    }
}