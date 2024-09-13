![Ultimate Time Logo](images/UltimateTimeLogo.png)

# Time Manager for GameMaker

Time Manager for GameMaker. Add a FixedStep event to your structs and objects that runs at a frequency decoupled from
the framerate.

Forget about having to worry about multiplying by a delta factor in order to decouple your physics from the framerate.

It also gives implicitly a slow-mo / fast-mode implementation.

## Table of Contents

1. [What does it do?](#what-does-it-do)
1. [Asset Overview](#asset-overview)
2. [Setup the TimeManager in your project](#setup-the-timemanager-in-your-project)
3. [Asset Overview](#asset-overview)
4. [Credits](#credits)
5. [License](#license)

# What does it do?

Time manager is a controller structs that holds a list of every registered instance/method that wants to be executed at
a fixed rate every frame.

Let´s say we want a physics system to be executed 240 times per second while the framerate of our game is 60. The time
manager will calculate this ratio and call the physics method 240/60 = 4 times. This helps us have a game that has no
problem working at 30/60/120/144 or any wanted framerate.

Also this manager has a speed variable which you can access and modify. Let's say we set the speed at 0.5. This will run
the physics at a 50% of speed.

## Asset Overview

Once you find yourself with a project with the Ultimate Time Asset you will see two folders: **UltimateTime by
MayitaMayoso ** and **UltimateTime Using Example**.

The first folder contains the essentials to make Ultimate Time work in your project. If you know how to use the asset
this is the only elements that you need to import.

- **TimeManager** (Script): Contains the TimeManager struct. It is the class that holds the logic of the asset.
- **ComponentParent** (Script): This asset is part of a bigger setup I use for my games where I have other managers such
  as CameraManager, InputManager, GeometryManager, etc... Including this file is just for compatibility in case of
  publishing my other assets.

UltimateTime Using Example is a very basic game to show how to set up the asset to make it work. At the day I'm writing
this readme, this just consists on a blob moving and jumping around

- **System** (Object): This is your System/Controller/Game/Manager/Everything object that just uses its own events to
  call the TimeManager. This Object needs to create the TimeManager, call StepBegin(), Setp() and StepEnd() of the Time
  in order to update the status of this.
- **TestRoom** (Room): Not a lot to say about this asset. Just to make very clear that the System object has to be
  created before any other object that you might want to use the Times with.
- **TestObject, TestStruct, Ground and Sprites** An example of how to call the Register and Unregister functions for
  either instances and structs.

## Setup the TimeManager in your project

As you can see on the System object from the example I give you, in order to work, the TimeManager needs you to the
following:

### A create event where you instantiate the struct and define the macro **_Time_**.

```c
// Create an instance of the Time manager
TimeManager = new TimeManager();

// Bind the Time manager to a macro so we can avoid calling System making it less verbose
#macro Time System.TimeManager
```

### A call to BeginStep, Step and StepEnd

```c
#event step_begin
Time.StepBegin();

#event step
Time.Step();

#event step_end
Time.StepEnd();
```

> **_NOTE:_** I prefer to implement TimeManager as a struct instead of an object since it is part of a bigger collection
> of managers on my personal project and I assume it will probably be the same with you.

## Register an instance

In order to register an instance method you should do as the following at the create event of the instance:

```c
Time.Register(id, function() { my_fixed_step_function() });
```

my_fixed_step_function() can be a call to event_user(0) where we write down our code or just in place.

## Register an struct method

Structs are a bit trickier. Instances can be checked if they don't exists anymore, TimeManager does so. Structs are
different and you cannot check if every reference to the struct has been deleted so you will have to manually unregister
the method.

This will be the struct definition

```c
function TestStruct() constructor {	
	static FixedStep = function() {
	    // Whatever
	};
	
	static CleanUp = function() {
		Time.Unregister(self);
	}
	
	Time.Register(self, FixedStep);
}
```

And this would be the struct usage

```c
#event create
myStruct = new TestStruct();

#event cleanup
myStruct.CleanUp();
```

# Licensing

This project is protected under the [MIT license](LICENSE.md).