/**
 * Created by steven.nguyen on 12/13/2016.
 */
component {
  // Place your content here
    public function init(){

    }

    public any function getJavaInstance(String javaClass){

        //create the loader
        loader = createObject("component", "javaloader.JavaLoader").init(loadJars());

        //at this stage we only have access to the class, but we don't have an instance

        //javaObject = loader.create("travalvai.utils.ImageUtil");
        javaObject = loader.create(javaClass);
        /*
        Create the instance, just like me would in createObject("java", "HelloWorld").init()
        This also could have been done in one line - loader.create("HelloWorld").init();
        */

        javaObjectInstance = javaObject.init();
        return javaObjectInstance;
    }

    private array function loadJars(){
        paths = arrayNew(1);
        /*
        This points to the jar we want to load.
        Could also load a directory of .class files
        */
        paths[1] = expandPath("/lib/rasia.util.jar");

        return paths;
    }
}
