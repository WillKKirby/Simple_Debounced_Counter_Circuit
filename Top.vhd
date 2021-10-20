-- Uses a 4-bit counter and a 14x8 bit ROM to output the Fibonacci
-- sequence in binary on the board's LEDs
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Top is
    -- Generic for Parameterizable Counter in Counter 
    Generic( LIMIT : natural := 25000000 );
    Port ( clk : in STD_LOGIC;
           COUNT : in STD_LOGIC;
           RESET : in STD_LOGIC;
           LEDs : out STD_LOGIC_VECTOR (3 downto 0));
end Top;

architecture Behavioral of Top is
    -- Signals for the debounced inputs
    signal COUNT_deb, RESET_deb : STD_LOGIC;
    -- Signal from the counter output to the ROM address select
    signal currentAddress : UNSIGNED (3 downto 0);
    -- This is the internal signal for the LED data to allow the LED's to be sliced.
    signal LED_int : STD_LOGIC_VECTOR(7 downto 0);
begin

-- Counter Debouncer for the COUNT input
debounce_count: entity work.Debouncer_new
generic map (LIMIT => LIMIT)
port map (
    clk => clk,
    Sig => COUNT,
    Deb_Sig => COUNT_deb );
    
-- Counter Debouncer for the RESET input
debounce_reset: entity work.Debouncer_new
generic map (LIMIT => LIMIT)
port map (
    clk => clk,
    Sig => RESET,
    Deb_Sig => RESET_deb );

-- The Counter
counter: entity work.Counter
port map (
    clk => clk,
    en => COUNT_deb,
    Rst => RESET_deb,
    count => currentAddress );
    
-- The ROM containing the Fibonacci sequence
rom: entity work.ROM
port map (
    address => currentAddress,
    data => LED_int );

-- Statement for slicing the bottom 4 bits of the LED data 
-- Due to the restricted number of LEDs 
LEDs <= LED_INT(3 downto 0); 

end Behavioral;
