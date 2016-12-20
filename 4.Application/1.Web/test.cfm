<html>
	<head><title>JavaLoader JAR Load Example</title></head>
	<style type="text/css">
		body {
			font-family: Verdana, Helvetica, san-serif;
			font-size: small;
		}
	</style>
	<body>
		<p>
			Example of creating a 'HelloWorld' Java object, by pulling in an external JAR file.
		</p>

		<p>
			The Jar file only contains a single class, 'HelloWorld', which is outlined below:
		</p>

		<cfscript>
			paths = arrayNew(1);

			/*
			This points to the jar we want to load.
			Could also load a directory of .class files
			*/
			paths[1] = expandPath("/lib/travalvai.jar");


			//create the loader
			loader = createObject("component", "javaloader.JavaLoader").init(paths);

			//at this stage we only have access to the class, but we don't have an instance
			//HelloWorld = loader.create("travalvai.HelloWorld");

			imageUtilLoader = loader.create("travalvai.utils.ImageUtil");

			/*
			Create the instance, just like me would in createObject("java", "HelloWorld").init()
			This also could have been done in one line - loader.create("HelloWorld").init();
			*/
			//hello = HelloWorld.init();
			imageUtil = imageUtilLoader.init();
		</cfscript>
		<cfoutput>
			<p>I say: Hello Java!  <br/>
			   Java says:
				<!--- let's say hello --->


			</p>
			<p>
				<img src='data:image/png/;base64,#imageUtil.convertImageToBase64String("C:/test/image1.png", "png", 0.5)#' width="215" height="auto" />
			</p>

			<p>

			</p>
		</cfoutput>

	</body>
</html>

