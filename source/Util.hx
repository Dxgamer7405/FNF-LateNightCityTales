package;

import openfl.utils.Assets;
import sys.io.File;
import sys.FileSystem;
import haxe.crypto.Md5;
import lime.system.System;
import openfl.display.BitmapData;

/*/*
Made by Idklool
*/

using StringTools;

class Util
{
  public static var path:String = System.applicationStorageDirectory;
  
  public static function getContent(id:String):String
  {
    #if mobile
    return Assets.getText(id);
    #else
    return File.getContent(id);
    #end
  }
  
  public static function exists(id:String):Bool 
  {
    #if mobile
    return Assets.exists(id);
    #else
    return FileSystem.exists(id);
    #end
  }
  
  public static function getBytes(id:String)
  {
    #if mobile
    return Assets.getBytes(id);
    #else
    return File.getBytes(id);
    #end
  }
  
  public static function readDirectory(library:String):Array<String>
  {
    var something:Array<String> = [];
    #if mobile 
    for (folder in Assets.list().filter(text -> text.contains(library)))
    {
      if (!folder.startsWith('.') && !something.contains(folder))
      something.push(folder);
    }
    return something;
    #else
    return FileSystem.readDirectory(library);
    #end
  }
  
  public static function fromFile(id:String)
  {
    #if mobile 
    return Assets.getBitmapData(id);
    #else
    return BitmapData.fromFile(id);
    #end
  }
  
  public static function getPath(id:String, ?ext:String = "")
	{
		#if android
		var file = Assets.getBytes(id);

		var md5 = Md5.encode(Md5.make(file).toString());

		if (FileSystem.exists(path + md5 + ext))
			return path + md5 + ext;


		File.saveBytes(path + md5 + ext, file);

		return path + md5 + ext;
		#else
		return #if sys Sys.getCwd() + #end id;
		#end
	}
}
