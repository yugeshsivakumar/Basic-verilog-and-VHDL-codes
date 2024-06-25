-- design 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ring_ctr is
  Port (
    clk : in std_logic;
    rstn : in std_logic;
    out : out std_logic_vector(3 downto 0)
  );
end ring_ctr;

architecture Behavioral of ring_ctr is
begin

  process(clk)
  begin
    if rising_edge(clk) then
      if rstn = '0' then
        out <= "1000";
      else
        out <= '0' & out(3 downto 1); -- Shift right by 1 bit
        if out = "0001" then
          out <= "1000";
        end if;
      end if;
    end if;
  end process;

end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
  signal clk : std_logic := '0';
  signal rstn : std_logic := '0';
  signal out : std_logic_vector(3 downto 0);
  
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
    rstn <= '1';
    wait for 4 ns;
    rstn <= '0';
    wait for 10 ns;
    report "Simulation finished";
    wait;
  end process;

  -- Instance of ring_ctr module
  ring_ctr_inst: entity work.ring_ctr
    port map (
      clk => clk,
      rstn => rstn,
      out => out
    );

  -- Monitor process
  monitor_proc: process (clk, rstn, out)
  begin
    wait until rising_edge(clk);
    report "Time=" & integer'image(time) &
           " rstn=" & std_logic'image(rstn) &
           " out=" & std_logic_vector'image(out);
    wait;
  end process;

end Behavioral;

