<cfcomponent>
  <cfscript>
    public string function getImageWithHandler(
      required string path,
      required numeric width, 
      required numeric height, 
      string scaleType = "scaleToFit",
      boolean hasWtm = false ) 
      cachedwithin="#createTimeSpan(0, 1, 0, 0)#"
      {
        var sType = LCase(scaleType);
        var wtm = hasWtm ? '-watermark':'';
        var thumbPath = GetDirectoryFromPath(path)&'/'&sType&wtm&'-'&width&'-'&height&'/'&GetFileFromPath(path) ;
        var resultPath = "ram://"&thumbPath ;
        if(not fileExists( resultPath ) ){
          var realPath = expandPath(path);
          var fImage = imageread(realPath) ;
          // add watermark (old code but not remove because it be need in future)
          // var wtmInfo = getWatermark();
          // if(hasWtm AND wtmInfo.url neq '' ){
          if(false){
            var watermark = imageRead(expandPath(wtmInfo.url));
            imageScaleToFit(watermark,int(fImage/10),'');
            // create transparency
            // ImageSetDrawingTransparency(myImage,10);
            switch(wtmInfo.location){
              case 'top-left':
                ImagePaste(fImage,watermark,wtmInfo.margin,wtmInfo.margin);
              break;
              case 'top-right':
                var iLeft  = fImage.width - (watermark.width+wtmInfo.margin) ;
                iLeft lt 0 ? wtmInfo.margin : iLeft ;
                var iTop  = wtmInfo.margin ;
                ImagePaste(fImage,watermark,iLeft,iTop);
              break;
              case 'bottom-left':
                var iLeft  = wtmInfo.margin ;
                var iTop  = fImage.height - (watermark.height+wtmInfo.margin) ;
                iTop lt 0 ? wtmInfo.margin : iTop ;
                ImagePaste(fImage,watermark,iLeft,iTop);
              break;
              case 'bottom-right':
                var iLeft  = fImage.width - (watermark.width+wtmInfo.margin) ;
                iLeft lt 0 ? wtmInfo.margin : iLeft ;
                var iTop  = fImage.height - (watermark.height+wtmInfo.margin) ;
                iTop lt 0 ? wtmInfo.margin : iTop ;
                ImagePaste(fImage,watermark,iLeft,iTop);
              break;
             
              default:
                ImagePaste(fImage,watermark,10,10);
              break;
            }
            ImageWrite(fImage,sPath,true);  
          }
          // scrop image 
          switch(sType){
            case "innercrop":
              if( width/height >= fImage.width/fImage.height ){
                imageScaleToFit(fImage,width,'');
                var y = int((fImage.height - height)/2) ;
                ImageCrop(fImage, 0, y, width, height) ;
              }else{
                imageScaleToFit(fImage,'',height);
                var x = int((fImage.width - width)/2) ;
                ImageCrop(fImage, x, 0, width, height) ;
              }
            break;
 
            case "outercrop":
              var backgroundImage = ImageNew('', width, height, 'rgb', '##222');
              if( width/height >= fImage.width/fImage.height ){
                imageScaleToFit(fImage,'',height);
                var x = int((width - fImage.width)/2) ;
                ImagePaste( backgroundImage, fImage, x, 0) ;
              }else{
                imageScaleToFit(fImage,width,'');
                var y = int((height - fImage.height)/2) ;
                ImagePaste( backgroundImage, fImage, 0, y) ;
              }
              fImage = backgroundImage ;
            break;
 
            case "resize":
              imageResize(fImage,width,height);
            break;
 
            case "scaletofit":
              newWidth = (width == 0 ? "":width);
              newHeight = (height == 0 ? "":height);
              imageScaleToFit(fImage,newWidth,newHeight);
            break;
 
            default:
              // show full image
            break;
          }
          // save to ram
          if(not directoryExists( "ram://"&GetDirectoryFromPath(thumbPath) ) ){
            DirectoryCreate( "ram://"&GetDirectoryFromPath(thumbPath) );
          }
          imageWrite(fImage,"ram://"&thumbPath,true);
        }
        return resultPath;
    }
  </cfscript>
<cffunction name = "image" access="remote">
  <cfcontent type="image/png" file="#getImageWithHandler( URL.path, URL.w, URL.h, URL.st )#" ></cfcontent>
</cffunction>
</cfcomponent>

 
<!--- <img src="/webinf-library-funciton/test.cfc?method=getImage&path=\media\2D17DA41D0\images\gallery1.jpg&w=100&h=100&st=scaletofit"> --->