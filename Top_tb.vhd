-- Testbench for the circuit outputting the stored Fibonachi numbers
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Top_tb is

end Top_tb;

architecture Behavioral of Top_tb is

-- Signals for Top module I/Os
signal clk, COUNT, RESET : STD_LOGIC;
signal LEDs : STD_LOGIC_VECTOR (3 downto 0);

constant clk_period : time := 10 ns;
-- Limit for the Parameterizable debouncer counter 
constant LIMIT : natural := 10;
-- Wait period for the debouncers to recognise the signal
constant WAIT_Period: natural := 10;
begin

-- Instansiate the UUT 
UUT: entity work.Top
    Generic Map (LIMIT => LIMIT)
    PORT MAP(
        clk => clk,
        COUNT => COUNT,
        RESET => RESET,
        LEDs => LEDs);
        
-- Clock process
clk_process: process
begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

TEST: process
begin
    -- wait for initialisation
    wait for 100 ns;
    -- The TB should change values on the clock's falling edge
    wait until falling_edge(clk);
    
    -- Initialise everything
    COUNT <= '0';
    RESET <= '1';
    wait for clk_period * WAIT_Period;
    RESET <= '0';
    wait for clk_period * WAIT_Period;
    
    -- Reset everything
    RESET <= '1';
    -- Wait for 10 clock cycles for debouncer
    wait for clk_period * WAIT_Period;
    RESET <= '0';
    
    -- Loop through all the numbers
    -- Also continue for a bit after it's completed
    increment_loop: for i in 0 to 17 loop
        -- Press the count button
        COUNT <= '1';
        -- Wait for 10 clock cycles for debouncer
        wait for clk_period * WAIT_Period;
        COUNT <= '0';
        wait for clk_period * WAIT_Period;
    end loop increment_loop;
    
    -- Test the reset
    RESET <= '1';
    wait for clk_period * WAIT_Period;
    RESET <= '0';
    
     -- Loop a few more times after the reset to show it restarting
    increment_loop2: for i in 0 to 3 loop
        -- Press the count button
        COUNT <= '1';
        -- Wait for 10 clock cycles for debouncer
        wait for clk_period * WAIT_Period;
        COUNT <= '0';
        wait for clk_period * WAIT_Period;
     end loop increment_loop2;
        
    wait;
    
end process;

end Behavioral;
