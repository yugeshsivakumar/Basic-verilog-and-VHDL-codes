-- design 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dec is
  Port (
    rst, clk, ud : in std_logic;
    count : out std_logic_vector(3 downto 0)
  );
end dec;

architecture Behavioral of dec is
begin

  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        count <= "0000";  -- Reset value
      elsif ud = '1' then
        count <= count + 1;  -- Increment count
        if count = "1111" then
          count <= "0000";  -- Wrap around if count reaches 15 (4'b1111)
        end if;
      else
        count <= count - 1;  -- Decrement count
        if count = "0000" then
          count <= "1111";  -- Wrap around if count reaches 0 (4'b0000)
        end if;
      end if;
    end if;
  end process;

end Behavioral;


-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
  signal rst, clk, ud : std_logic;
  signal count : std_logic_vector(3 downto 0);
  
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
    ud <= '1';   -- Set direction to increment
    wait for 30 ns;
    ud <= '0';   -- Set direction to decrement
    wait for 31 ns;
    ud <= '1';   -- Set direction to increment again
    wait for 25 ns;
    ud <= '0';   -- Set direction to decrement again
    wait for 10 ns;  -- Allow for additional simulation time
    report "Simulation finished";
    wait;
  end process;

  -- Instance of dec module
  dec_inst: entity work.dec
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
