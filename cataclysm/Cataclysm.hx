package cataclysm;

#if openfl
import openfl.events.UncaughtErrorEvent;
import openfl.display.Bitmap;
#end

import haxe.io.Path;
import haxe.CallStack;
using StringTools;

class Cataclysm
{
	public var logPath:String = null;
	public var logTitle:String = null;
	public var startTime:Date = null;
	public var onApplicationCrash:Void -> Void = null;
	public function new()
	{
		print("Thanks For Using Cataclysm.");
	}

	public function setup(path:String = null, title:String = null)
	{
		startTime = Date.now();
		logPath = './$path' ?? './crashlogs';
		logTitle = title ?? 'Cataclysm';
		print("Logging Path = " + logPath + " | Title = " + logTitle);
		CatUtil.createDirIfGone(logPath);
		#if (openfl)
		openfl.Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		print("You Are Using OpenFL. All Should Function As Intended.");
		#end
	}

	#if openfl
	private function onCrash(e:UncaughtErrorEvent)
	{
		print('Crash Caught. Error Type : ${e.type}');
		print('Error Message : ${e.error}');
		final stack:Array<String> = [];
		#if HXCPP_STACK_TRACE
		stack.push(CallStack.toString(CallStack.exceptionStack(true)));
		#end
		var dateNow:String = Date.now().toString().replace(" ", "_");
		var message:String = '${logTitle}\n[';
		message+= "\nApp Title: " + openfl.Lib.application.meta.get('file');
		message+= "\nApp Company: " + openfl.Lib.application.meta.get('company');
		message += "\nApp Package(?): " + openfl.Lib.application.meta.get('packageName');
		message += "\nApp Version: " + openfl.Lib.application.meta.get('version');
		message += "\nBuild Number: " + openfl.Lib.application.meta.get('build');
		message += "\nApp Crash Date/Time: " + dateNow;
		message += "\nApp Duration: " + (getTimeStr((Date.now().getTime()-startTime.getTime())));
		message += "\n]\nCrash Report\n[";
		message += "\nError Type: " + e.error;
		message += "\nError Message: " + e.type; // weird shit
		message += "\nStack Log:";
		message+= Std.string(stack).replace("[", "").replace("]", "");
		message += "\n]";
		print('$message');
		dateNow = dateNow.replace(":", "-");
		final path = '$logPath/$logTitle' + "_" + dateNow + ".txt";
		print(path);
		#if sys
		sys.io.File.saveContent(path, message);
		print('A Crashlog Has Been Generated At $logPath.'); 
		#end

		if (onApplicationCrash != null)
			onApplicationCrash();

		Sys.exit(1);
	}
	#end

	private function print(m:Dynamic)
	{
		#if CATACLYSM_DEBUG
		return Sys.println('[Catalysm] | $m');
		#end
	}
	/**
	 * Stolen From Crashdumper. Author : Lars Doucet
	 * @param ms 
	 * @return String
	 */
	private function getTimeStr(ms:Float):String
	{
		var seconds:Int = 0;
		var minutes:Int = 0;
		var hours:Int = 0;
		
		var seconds:Int = Std.int(ms / 1000);
		if (seconds > 60) {
			minutes = Std.int(seconds / 60);
			seconds = seconds % 60;
			if (minutes > 60) {
				  hours = Std.int(minutes / 60);
				minutes = minutes % 60;
			}
		}
		return padDigit(hours, 2) + ":" + padDigit(minutes, 2) + ":" + padDigit(seconds, 2);
	}
	/**
	 * Stolen From Crashdumper. Author : Lars Doucet
	 * @param ms 
	 * @return String
	 */
	private function padDigit(i:Int, digits:Int):String
	{
		var str:String = Std.string(i);
		while (str.length < digits)
		{
			str = "0" + str;
		}
		return str;
	}
		
}