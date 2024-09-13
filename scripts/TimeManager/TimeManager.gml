#macro second *Time.sec
#macro minute second*60
#macro hour minute*60

function TimeManager() : Component() constructor {
    
    delta = 0;				// Delta is the relation between the real fps and the desired ones
    rawDelta = 0;			// RawDelta is the same as delta but without multiplying by speed
    speed = 1;				// Speed is a factor we will use to speed up or down the time in order to make slow mo
    sec = 240;				// cicles is the intended speed of the game when designing the game
    accumulatedDelta = 0;
    wholeDelta = 0;
    frame = 0;
    instToEvents = array_create(0);
	
	static Register = function(inst, event) {
    	array_push(instToEvents, [inst, method(inst, event)]);
    };
	
	static Unregister = function(inst) {
		index = array_find_index(instToEvents, function(el, inst) { return el == inst; });
		array_delete(instToEvents, index, 1);
    };
    
    static Step = function() {
        // Calculate the amount of times we should run the fixed step instToEvents of each instance
        accumulatedDelta += frac(delta);
        wholeDelta = floor(delta) + floor(accumulatedDelta);
        accumulatedDelta = frac(accumulatedDelta);
    }
    
    static StepBegin = function() {
        // We calculate the time between last frame and current and we make a normalized factor
        rawDelta = ( delta_time * sec ) / 1000000;
        rawDelta = min(rawDelta, 16);
        delta = speed * rawDelta;
    }
    
    static StepEnd = function() {
        repeat(wholeDelta) {
        	for( var i=0 ; i<array_length(instToEvents) ; i++ ) {
        		if (instance_exists(instToEvents[i][0])) {
					method_call(instToEvents[i][1], []);
        		} else {
        			array_delete(instToEvents, i, 1);
        			i--;
        		}
        	}
        	frame++;
        }
    }
}