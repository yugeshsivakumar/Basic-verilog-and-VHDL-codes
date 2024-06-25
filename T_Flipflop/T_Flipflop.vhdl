-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity t_ff is
  Port (
    in : in std_logic;
    clk, rst : in std_logic;
    q, qb : out std_logic
  );
end t_ff;

architecture Behavioral of t_ff is
begin

  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        q <= '0';  -- Reset state
      else
        if in = '0' then
          q <= in;  -- Set q to input value when in is '0'
        else
          q <= not q;  -- Toggle q when in is '1'
        end if;
      end if;
      qb <= not q;  -- qb is the complement of q
    end if;
  end process;

end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
  signal in, clk, rst : std_logic;
  signal q, qb : std_logic;
  
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
    for i in 0 to 4 loop
      in <= std_logic((i mod 2));  -- Alternating '0' and '1'
      wait for CLK_PERIOD;
    end loop;
    wait for CLK_PERIOD; -- Wait one more clock cycle before finishing
    report "Simulation finished";
    wait;
  end process;

  -- Instance of t_ff module
  t_ff_inst: entity work.t_ff
    port map (
      in => in,
      clk => clk,
      rst => rst,
      q => q,
      qb => qb
    );

  -- Monitor process
  monitor_proc: process (clk, rst, in, q, qb)
  begin
    wait until rising_edge(clk);
    report "Time=" & integer'image(time) &
           " Reset=" & std_logic'image(rst) &
           " In=" & std_logic'image(in) &
           " Q=" & std_logic'image(q) &
           " Qb=" & std_logic'image(qb);
    wait;
  end process;

end Behavioral;
