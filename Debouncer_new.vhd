-- Parameterizable Style Counter 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.DigEng.all;

entity Debouncer_new is
    -- Generic will be inherited from the top level
    Generic (LIMIT: natural := 25000000);
    Port ( clk : in STD_LOGIC;
           Sig : in STD_LOGIC;
           Deb_Sig : out STD_LOGIC);
end Debouncer_new;

architecture Behavioral of Debouncer_new is
-- signals 
signal rst, en, D, Q : std_logic;
-- The count signal is Parameterizable to fit any given size 
signal count : UNSIGNED (LOG2(LIMIT)-1 downto 0);

begin

-- Internal signal logic 
rst <= not sig;
en <= sig and not D;
D <= '1' when count = LIMIT-1 else '0';
Deb_Sig <= D and not Q;

-- Nested Para-Counter 
PCounter : entity work.Para_Counter
-- Passing Limit for Counter 
generic map (LIMIT => LIMIT)
port map (
    clk => clk,
    en => en,
    rst => rst,
    count =>   count);
    
-- Non-reset D-type Flip-flop 
DFF: process (clk)
begin
    if (rising_edge(clk)) then
        Q <= D;
    end if;
end process;

end Behavioral;