/**
 * Created by steven.nguyen on 12/13/2016.
 */
component {
  // Place your content here
    public function init(){

    }

    /*
    *Convert image to base64
    *
    */
    public function convertImageToBase64(String imagePath, String formatName, Numeric scale){
        var imageUtil = new JavaUtil().getJavaInstance("rasia.utils.ImageUtil");
        var strBase64 = imageUtil.convertImageToBase64String(imagePath, formatName, scale);
        return strBase64;
    }

    /*
    * Convert image to base64
    * Height will be calculated to maintain ratio along with Image' width
    */
    public function convertImageToBase64MaintainRatio(String imagePath, String formatName, Numeric imageWidth, Boolean maintainRatio){
        var imageUtil = new JavaUtil().getJavaInstance("rasia.utils.ImageUtil");
        var strBase64 = imageUtil.convertImageToBase64String(imagePath, formatName, imagewidth, maintainRatio);
        return strBase64;
    }
}
