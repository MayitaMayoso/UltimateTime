// Create an instance of the time manager
timeManager = new TimeManager();

// Bind the time manager to a macro so we can avoid calling System making it less verbose
#macro Time System.timeManager