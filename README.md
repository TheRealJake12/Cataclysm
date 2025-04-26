# Cataclysm - An OpenFL Crash Logger For C++ Targets.

# What is this?
`Cataclysm` Is An Open-Source Crash Handler / Logger For [OpenFL](https://www.openfl.org/) Applications.

I Designed This To Be Used Alongside `Cataclysmic Engine`, A [Friday Night Funkin'](https://github.com/FunkinCrew/Funkin) Engine.

# Key Features

Highly Informative Crash Logger That Includes The Following Information:
- App Title
- App Company
- App Package(???)
- App Build Number
- How Long The App Was Open
- When The App Crashed
- Error Type
- Error Message
- Stack Log For Knowing What Lines Specifically Crashed The App

# How Do I Use This?

First, Ensure Your [Haxe](https://haxe.org/) Version Is Atleast `4.3.6` Or Higher.
Next, Make Sure These Libraries Are Moderately Up-To-Date.
```
openfl >= 9.4.1
lime >= 8.2.2
hxcpp >= 4.3.2
```

Now, Install The Library.
`haxelib git cataclysm https://github.com/TheRealJake12/cataclysm.git`

In Your `Project.xml`, Add The Haxelib Define.
`<haxelib name="cataclysm"/>`

## NOTICE

**THERE ARE SOME PERFORMANCE DOWNSIDES TO USING CATACLYSM.**

Due To HXCPP Being Funny With Error Handling, Cataclysm Defines The Following To Try And Catch Errors.

```xml
<haxedef name="HXCPP_CHECK_POINTER" />
<haxedef name="HXCPP_CATCH_SEGV" />
<haxedef name="HXCPP_STACK_LINE" />
<haxedef name="HXCPP_STACK_TRACE" />
<haxedef name="openfl-enable-handle-error" />
```

It Shouldn't Slow Things Down Too Much Though.


### Initializing Cataclysm

In Your `Main.hx` Or Alternative, Import `cataclysm.Cataclysm`;

```haxe
import cataclysm.Cataclysm;
```

Then After Your App Has Initialized, Add The Following:

```haxe
var crash_handler:Cataclysm = new Cataclysm();
crash_handler.setup("crashlogs", "AppName");
```

The First Argument Of `setup` Is Where The Logs Are Saved. `crashlogs` Will Output The Logs At `bin/crashlogs`.
The Second Argument Is The Title Of The Log *(In Addition To The Date And Time Of The Crash)*. 

An Example Of This Would Be `Cataclysm-Crashlog_2025-04-24_19-39-46`.

There Is Also An Optional Callback `onApplicationCrash` That You Can Call Whenever Cataclysm Has Detected A Crash.

It Works As Following:

```haxe
var crash_handler:Cataclysm = new Cataclysm();
crash_handler.setup("crashlogs", "AppName");
crash_handler.onApplicationCrash = function()
{
trace("The App Has Crashed. Check The Logs Folder For More Info...");
};
```

Thank You For Using Cataclysm, If You Have Any Features Or Additions You Want To Add Or Suggest, Feel Free To Do So.

# Credits

**[therealjake_12](https://github.com/TheRealJake12)** - Writing 99% Of Cataclysm

**[Lars Doucet](https://github.com/larsiusprime)** - Writing Crashdumper (Which This Is Inspired From) And That One Date To String Function
