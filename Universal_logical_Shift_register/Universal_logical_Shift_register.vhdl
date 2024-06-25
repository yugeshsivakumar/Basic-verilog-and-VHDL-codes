-- design 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sreg is
  Port (
    rst, clk, ud : in std_logic;
    count : out std_logic_vector(8 downto 0)
  );
end sreg;

architecture Behavioral of sreg is
begin

  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        count <= "10110010";  -- Reset value
      elsif ud = '1' then
        count <= count(7 downto 0) & '0';  -- Shift right (ud = '1')
      else
        count <= '0' & count(8 downto 1);  -- Shift left (ud = '0')
      end if;
    end if;
  end process;

end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
  signal rst, clk, ud : std_logic;
  signal count : std_logic_vector(8 downto 0);
  
  constant CLK_PERIOD : time := 10 ns;  -- Simulation clock period
  
begin

  -- Clock generation process
  clk_gen_proc: process
  begin
    while true loop
      clk <= '0';
      wait for CLK_PERIOD / 2;
      clk <= '1';
      wait for CLK_PERIOD / 2;
    end loop;
  end process;

  -- Stimulus process
  stim_proc: process
  begin
    wait for 5 ns;
    rst <= '1';  -- Assert reset
    wait for 10 ns;
    rst <= '0';  -- Release reset
    wait for 5 ns;
    ud <= '1';   -- Set direction to right
    wait for 5 ns;
    ud <= '0';   -- Set direction to left
    wait for 14 ns;  -- Allow for additional simulation time
    report "Simulation finished";
    wait;
  end process;

  -- Instance of sreg module
  sreg_inst: entity work.sreg
    port map (
      rst => rst,
      clk => clk,
      ud => ud,
      count => count
    );

  -- Monitor process
  monitor_proc: process (clk, rst, ud, count)
  begin
    wait until rising_edge(clk);
    report "Time=" & integer'image(time) &
           " Rst=" & std_logic'image(rst) &
           " Ud=" & std_logic'image(ud) &
           " Count=" & to_string(count);
    wait;
  end process;

end Behavioral;


