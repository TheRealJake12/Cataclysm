package cataclysm;

#if sys
import sys.FileSystem;
#end

class CatUtil
{
	#if sys
	public static function createDirIfGone(dir:String)
	{
		if (!FileSystem.isDirectory(dir))
			FileSystem.createDirectory(dir);
	}
	#end
}