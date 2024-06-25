-- design 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sipo is
  Port (
    din : in std_logic;
    clk : in std_logic;
    rst : in std_logic;
    dout : out std_logic_vector(3 downto 0)
  );
end sipo;

architecture Behavioral of sipo is

begin

  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        dout <= (others => '0');
      else
        dout(3) <= din;
        dout(2) <= din;
        dout(1) <= din;
        dout(0) <= din;
        
        -- Displaying the values for debugging purposes
        report "Time=" & integer'image(time) &
               " rst=" & std_logic'image(rst) &
               " din=" & std_logic'image(din) &
               " dout=" & std_logic_vector'image(dout);
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
  signal rst : std_logic := '1'; -- Active-low reset
  signal din : std_logic := '0';
  signal dout : std_logic_vector(3 downto 0);
  
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
    rst <= '0';  -- Release reset
    wait for 10 ns;
    for i in 0 to 9 loop
      din <= '0';
      wait for CLK_PERIOD;
      din <= '1';
      wait for CLK_PERIOD;
    end loop;
    wait for CLK_PERIOD; -- Wait one more clock cycle before finishing
    report "Simulation finished";
    wait;
  end process;

  -- Instance of sipo module
  sipo_inst: entity work.sipo
    port map (
      din => din,
      clk => clk,
      rst => rst,
      dout => dout
    );

  -- Monitor process
  monitor_proc: process (clk, rst, din, dout)
  begin
    wait until rising_edge(clk);
    report "Time=" & integer'image(time) &
           " rst=" & std_logic'image(rst) &
           " din=" & std_logic'image(din) &
           " dout=" & std_logic_vector'image(dout);
    wait;
  end process;

end Behavioral;
