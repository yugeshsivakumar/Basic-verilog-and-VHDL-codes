-- design 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity srff is
  Port (
    s, r : in std_logic;
    clk, rst : in std_logic;
    q : out std_logic
  );
end srff;

architecture Behavioral of srff is

begin

  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '0' then
        case s & r is
          when "00" => q <= q;
          when "01" => q <= '0';
          when "10" => q <= '1';
          when others => q <= 'Z';  -- Handle default case
        end case;
      else
        q <= '0';
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
  signal s, r, clk, rst : std_logic;
  signal q : std_logic;
  
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
    wait for 10 ns;
    for i in 0 to 3 loop
      s <= std_logic(to_unsigned(i, s'length));
      r <= std_logic(to_unsigned(i, r'length));
      wait for CLK_PERIOD;
    end loop;
    wait for CLK_PERIOD; -- Wait one more clock cycle before finishing
    report "Simulation finished";
    wait;
  end process;

  -- Instance of srff module
  srff_inst: entity work.srff
    port map (
      s => s,
      r => r,
      clk => clk,
      rst => rst,
      q => q
    );

  -- Monitor process
  monitor_proc: process (clk, rst, s, r, q)
  begin
    wait until rising_edge(clk);
    report "Time=" & integer'image(time) &
           " rst=" & std_logic'image(rst) &
           " s=" & std_logic'image(s) &
           " r=" & std_logic'image(r) &
           " q=" & std_logic'image(q);
    wait;
  end process;

end Behavioral;
