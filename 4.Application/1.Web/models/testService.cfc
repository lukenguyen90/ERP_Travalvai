/**
 * Created by steven.nguyen on 12/12/2016.
 */
component {
    // Place your content here

    function sayHello()    {

        paths = arrayNew(1);

/*
This points to the jar we want to load.
Could also load a directory of .class files
*/
        paths[1] = expandPath("/lib/travalvai.jar");


//create the loader
        loader = createObject("component", "javaloader.JavaLoader").init(paths);

//at this stage we only have access to the class, but we don't have an instance
        HelloWorld = loader.create("travalvai.HelloWorld");

/*
Create the instance, just like me would in createObject("java", "HelloWorld").init()
This also could have been done in one line - loader.create("HelloWorld").init();
*/
        hello = HelloWorld.init();

        writeDump(hello.sayHello()); abort;

        return "Hello new day";
       /* paths = arrayNew(1);
        paths[1] =expandPath('helloworld.jar');
  loader = createObject("component", "javaloader.JavaLoader").init(paths);
  HelloWorld = loader.create("HelloWorld");*/

//oImageUtil = javaloader.create("HelloWorld").init().sayHello();
        //var helloWorld = helloWorldLoader.init();
    }
}
