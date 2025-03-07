`timescale 10ns / 1ps

module automatic_washing_machine_tb;
    reg clk, reset, door_close, start, filled, detergent_added, cycle_timeout, drained, spin_timeout;
    wire door_lock, motor_on, fill_value_on, drain_value_on, done, soap_wash, water_wash;

    // Instantiate the washing machine module
    automatic_washing_machine uut (
        .clk(clk), 
        .reset(reset), 
        .door_close(door_close), 
        .start(start), 
        .filled(filled), 
        .detergent_added(detergent_added), 
        .cycle_timeout(cycle_timeout), 
        .drained(drained), 
        .spin_timeout(spin_timeout), 
        .door_lock(door_lock), 
        .motor_on(motor_on), 
        .fill_value_on(fill_value_on), 
        .drain_value_on(drain_value_on), 
        .done(done), 
        .soap_wash(soap_wash), 
        .water_wash(water_wash)
    );

    // Generate clock signal
    always #5 clk = ~clk; // Clock period of 10ns

    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        door_close = 0;
        start = 0;
        filled = 0;
        detergent_added = 0;
        cycle_timeout = 0;
        drained = 0;
        spin_timeout = 0;

        // Reset the FSM
        #10 reset = 0;
        #10 reset = 1;
        
        // Start the washing machine
        #10 door_close = 1;
        #10 start = 1;
        
        // Simulate filling water
        #20 filled = 1;
        
        // Add detergent
        #20 detergent_added = 1;
        
        // Run wash cycle
        #50 cycle_timeout = 1;
        
        // Drain water
        #20 drained = 1;
        
        // Start spinning
        #20 spin_timeout = 1;
        
        // End simulation
        #20 $stop;
    end

    // Monitor the state transitions
    initial begin
        $monitor("Time=%0t | State Signals: door_lock=%b, motor_on=%b, fill_value_on=%b, drain_value_on=%b, done=%b, soap_wash=%b, water_wash=%b", 
                 $time, door_lock, motor_on, fill_value_on, drain_value_on, done, soap_wash, water_wash);
    end

endmodule
